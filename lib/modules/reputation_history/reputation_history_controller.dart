import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sof_app/models/language_model.dart';
import 'package:sof_app/utils/enums.dart';

import '../../models/reputation_model.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';
import '../../service/bookmark_service.dart';
import '../user_page/user_page_controller.dart';

class ReputationHistoryController extends GetxController with GetTickerProviderStateMixin {
  final UserService _userService = UserService();
  final BookmarkService _bookmarkService = BookmarkService();
  final scrollController = ScrollController();
  final Rx<UserModel> userModel = UserModel().obs;
  final RxBool isStatsLoading = false.obs;
  final RxBool isReputationLoading = false.obs;
  final RxBool isUserBookmarked = false.obs;

  // Observable variables
  final RxList<ReputationModel> reputationHistory = <ReputationModel>[].obs;
  final RxList<LanguageModel> languageModel = <LanguageModel>[].obs;
  final RxList<ReputationModel> repuHistoryChart = <ReputationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxInt selectedUserId = 0.obs;
  final RxInt totalAnswer = 0.obs;
  final RxInt totalQuestion = 0.obs;
  final RxInt totalComment = 0.obs;
  final RxBool isGetLanguages = false.obs;

  late final TabController tabController;

  final List<Tab> tabsData = [Tab(text: "Profile"), Tab(text: "Reputation"), Tab(text: "Analysis")];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    scrollController.addListener(_onScroll);
  }

  bool isBookmarked(int userId) {
    return _bookmarkService.isBookmarked(userId);
  }

  void toggleBookmark(UserModel user) {
    final userId = user.userId ?? 0;
    _bookmarkService.toggleBookmark(userId);
    isUserBookmarked.value = _bookmarkService.isBookmarked(userId);

    // Sync with UserPageController
    try {
      final userPageController = Get.find<UserPageController>();
      userPageController.bookmarkStates[userId] = isUserBookmarked.value;
      userPageController.users.refresh();
    } catch (_) {
      // UserPageController might not be initialized yet
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && hasMore.value) {
        loadReputationHistory();
      }
    }
  }

  Future<void> getTotal({int? userId}) async {
    if (userId == null && selectedUserId.value == 0) return;
    try {
      isStatsLoading.value = true;
      final result = await Future.wait([
        _getTotalAnswer(id: userId ?? selectedUserId.value),
        _getTotalQuestion(id: userId ?? selectedUserId.value),
        _getTotalComment(id: userId ?? selectedUserId.value),
      ]);
      if (result.isNotEmpty) {
        totalAnswer.value = result[0];
        totalQuestion.value = result[1];
        totalComment.value = result[2];
      } else {
        totalAnswer.value = 0;
        totalQuestion.value = 0;
        totalComment.value = 0;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isStatsLoading.value = false;
    }
  }

  Future<int> _getTotalAnswer({required int id}) async {
    try {
      final response = await _userService.getTotal(userId: id, type: ETypeParams.ANSWER);
      return response != 0 ? response : 0;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
      return 0;
    }
  }

  Future<int> _getTotalQuestion({required int id}) async {
    try {
      final response = await _userService.getTotal(userId: id, type: ETypeParams.QUESTIONS);
      return response != 0 ? response : 0;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
      return 0;
    }
  }

  Future<int> _getTotalComment({required int id}) async {
    try {
      final response = await _userService.getTotal(userId: id, type: ETypeParams.COMMENTS);
      return response != 0 ? response : 0;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
      return 0;
    }
  }

  Future<void> loadReputationHistory({bool refresh = false, int? userId}) async {
    if (isLoading.value) return;
    if (!hasMore.value && !refresh) return;
    if (userId == null && selectedUserId.value == 0) return;

    try {
      isLoading.value = true;

      if (refresh) {
        currentPage.value = 1;
        reputationHistory.clear();
        hasMore.value = true;
      }

      final response = await _userService.getUserReputation(
        userId: userId ?? selectedUserId.value,
        page: currentPage.value,
        pageSize: pageSize,
      );

      if (response.items != null && response.items!.isNotEmpty) {
        if (refresh) {
          reputationHistory.value = response.items!;
        } else {
          reputationHistory.addAll(response.items!);
        }
        hasMore.value = response.hasMore ?? false;
        if (hasMore.value) {
          currentPage.value++;
        }
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      if (!refresh) {
        currentPage.value--;
      }
      Get.snackbar('Error', 'Failed to load reputation history: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
      isReputationLoading.value = false;
    }
  }

  Future<void> loadReputationForChart({required int userId}) async {
    try {
      final response = await _userService.getUserReputation(userId: userId, page: 1, pageSize: 70);
      if (response.items != null && response.items!.isNotEmpty) {
        final now = DateTime.now();
        final sevenDaysAgo = now.subtract(const Duration(days: 7));

        final filteredItems =
            response.items!.where((item) {
              if (item.creationDate == null) return false;
              final itemDate = DateTime.fromMillisecondsSinceEpoch(item.creationDate! * 1000);
              return itemDate.isAfter(sevenDaysAgo) || itemDate.isAtSameMomentAs(sevenDaysAgo);
            }).toList();

        filteredItems.sort((a, b) => (a.creationDate ?? 0).compareTo(b.creationDate ?? 0));
        repuHistoryChart.value = filteredItems;
      } else {
        repuHistoryChart.value = [];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reputation history: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> refreshReputationHistory({int? userId}) async {
    await loadReputationHistory(refresh: true, userId: userId);
  }

  void setSelectedUserId(int userId) {
    selectedUserId.value = userId;
    reputationHistory.clear();
    currentPage.value = 1;
    hasMore.value = true;
    totalAnswer.value = 0;
    totalQuestion.value = 0;
    totalComment.value = 0;

    Future.wait([getTotal(userId: userId), refreshReputationHistory(userId: userId)]);
  }

  Future<void> getTopLanguages({required int userId}) async {
    isGetLanguages.value = true;
    try {
      final response = await _userService.getTopLanguages(userId: userId);
      languageModel.value = response.items ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load top languages: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isGetLanguages.value = false;
    }
  }

  String getReadableReputationType(String type) {
    switch (type.toLowerCase()) {
      // Voting related
      case 'post_upvoted':
        return 'Upvoted';
      case 'post_unupvoted':
        return 'Upvote removed';
      case 'post_downvoted':
        return 'Downvoted';
      case 'post_undownvoted':
        return 'Downvote removed';
      case 'voter_downvotes':
        return 'Downvoted by voter';
      case 'voter_undownvotes':
        return 'Downvote removed by voter';
      case 'example_upvoted':
        return 'Example upvoted';
      case 'example_unupvoted':
        return 'Example upvote removed';
      case 'doc_link_upvoted':
        return 'Documentation link upvoted';
      case 'doc_link_unupvoted':
        return 'Documentation link upvote removed';

      // Answer acceptance related
      case 'answer_accepted':
        return 'Answer accepted';
      case 'answer_unaccepted':
        return 'Answer unaccepted';
      case 'asker_accepts_answer':
        return 'Accepted answer';
      case 'asker_unaccept_answer':
        return 'Unaccepted answer';

      // Edit related
      case 'suggested_edit_approval_received':
        return 'Edit approved';
      case 'suggested_edit_approval_overridden':
        return 'Edit approval overridden';
      case 'proposed_change_approved':
        return 'Proposed change approved';
      case 'doc_source_removed':
        return 'Documentation source removed';

      // Flag related
      case 'post_flagged_as_spam':
        return 'Post flagged as spam';
      case 'post_flagged_as_offensive':
        return 'Post flagged as offensive';

      // Bounty related
      case 'bounty_given':
        return 'Bounty given';
      case 'bounty_earned':
        return 'Bounty earned';
      case 'bounty_cancelled':
        return 'Bounty cancelled';

      // Post status related
      case 'post_deleted':
        return 'Post deleted';
      case 'post_undeleted':
        return 'Post restored';
      case 'post_migrated':
        return 'Post migrated';

      // User related
      case 'user_deleted':
        return 'User deleted';

      // Special cases
      case 'association_bonus':
        return 'Association bonus';
      case 'arbitrary_reputation_change':
        return 'Reputation changed';
      case 'vote_fraud_reversal':
        return 'Vote fraud reversed';

      default:
        return type.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    totalAnswer.value = 0;
    totalQuestion.value = 0;
    totalComment.value = 0;
    super.onClose();
  }
}
