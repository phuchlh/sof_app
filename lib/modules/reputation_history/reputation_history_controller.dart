import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sof_app/models/language_model.dart';
import 'package:sof_app/utils/enums.dart';

import '../../models/reputation_model.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';

class ReputationHistoryController extends GetxController
    with GetTickerProviderStateMixin {
  final UserService _userService = UserService();
  final scrollController = ScrollController();
  final Rx<UserModel> userModel = UserModel().obs;
  final RxBool isStatsLoading = false.obs;
  final RxBool isReputationLoading = false.obs;

  // Observable variables
  final RxList<ReputationModel> reputationHistory = <ReputationModel>[].obs;
  final RxList<LanguageModel> languageModel = <LanguageModel>[].obs;
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

  final List<Tab> tabsData = [
    Tab(text: "Profile"),
    Tab(text: "Reputation"),
    Tab(text: "Analysis"),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
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
      Get.snackbar(
        'Error',
        'Failed to load user data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isStatsLoading.value = false;
    }
  }

  Future<int> _getTotalAnswer({required int id}) async {
    try {
      final response = await _userService.getTotal(
        userId: id,
        type: ETypeParams.ANSWER,
      );
      if (response != 0) {
        return response;
      } else {
        return 0;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return 0;
  }

  Future<int> _getTotalQuestion({required int id}) async {
    try {
      final response = await _userService.getTotal(
        userId: id,
        type: ETypeParams.QUESTIONS,
      );
      if (response != 0) {
        return response;
      } else {
        return 0;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return 0;
  }

  Future<int> _getTotalComment({required int id}) async {
    try {
      final response = await _userService.getTotal(
        userId: id,
        type: ETypeParams.COMMENTS,
      );
      if (response != 0) {
        return response;
      } else {
        return 0;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return 0;
  }

  Future<void> loadReputationHistory({
    bool refresh = false,
    int? userId,
  }) async {
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
      Get.snackbar(
        'Error',
        'Failed to load reputation history: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isReputationLoading.value = false;
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

    // Load data in parallel
    Future.wait([
      getTotal(userId: userId),
      refreshReputationHistory(userId: userId),
    ]);
  }

  Future<void> getTopLanguages({required int userId}) async {
    isGetLanguages.value = true;
    try {
      final response = await _userService.getTopLanguages(userId: userId);
      if (response.items != null && response.items!.isNotEmpty) {
        isGetLanguages.value = false;
        languageModel.value = response.items!;
      } else {
        isGetLanguages.value = false;
        languageModel.value = [];
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load top languages: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
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
