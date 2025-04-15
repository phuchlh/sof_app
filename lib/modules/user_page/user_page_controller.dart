import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../service/user_service.dart';
import '../../service/bookmark_service.dart';
import '../reputation_history/reputation_history_controller.dart';

class UserPageController extends GetxController {
  final UserService _userService = UserService();
  final BookmarkService _bookmarkService = BookmarkService();
  final scrollController = ScrollController();

  // Observable variables
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxInt selectedToggleIndex = 0.obs;
  final RxBool showBookmarkedOnly = false.obs;
  final RxMap<int, bool> bookmarkStates = <int, bool>{}.obs;

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  Timer? _searchDebounce;

  @override
  void onInit() {
    loadUsers();
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void filterUsersByName(String query) {
    searchQuery.value = query;
    _searchDebounce?.cancel();

    if (query.isEmpty) {
      loadUsers(refresh: true);
    } else {
      _searchDebounce = Timer(const Duration(milliseconds: 1000), () {
        if (searchQuery.value == query) {
          loadUsers(refresh: true, inname: query);
        }
      });
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value &&
        hasMore.value) {
      loadUsers();
    }
  }

  bool isBookmarked(int userId) {
    return bookmarkStates[userId] ?? _bookmarkService.isBookmarked(userId);
  }

  void toggleBookmark(UserModel user) {
    final userId = user.userId ?? 0;
    _bookmarkService.toggleBookmark(userId);
    bookmarkStates[userId] = _bookmarkService.isBookmarked(userId);

    try {
      final reputationController = Get.find<ReputationHistoryController>();
      if (reputationController.userModel.value.userId == userId) {
        reputationController.isUserBookmarked.value = bookmarkStates[userId] ?? false;
      }
    } catch (_) {
      // ReputationHistoryController might not be initialized yet
    }

    users.refresh();
  }

  void toggleFilterByIndex(int index) {
    if (selectedToggleIndex.value != index) {
      selectedToggleIndex.value = index;
      showBookmarkedOnly.value = index == 1;
    }
  }

  List<UserModel> get filteredUsers {
    if (showBookmarkedOnly.value) {
      return users.where((user) => isBookmarked(user.userId ?? 0)).toList();
    }
    return users;
  }

  Future<void> loadUsers({
    bool refresh = false,
    String order = 'desc',
    String sort = 'reputation',
    String site = 'stackoverflow',
    String inname = '',
  }) async {
    if (isLoading.value || (!hasMore.value && !refresh)) return;

    try {
      isLoading.value = true;

      if (refresh) {
        currentPage.value = 1;
        users.clear();
        hasMore.value = true;
      }

      final response = await _userService.getUsers(
        page: currentPage.value,
        pageSize: pageSize,
        order: order,
        sort: sort,
        site: site,
        inname: inname,
      );

      if (refresh) {
        users.value = response.items ?? [];
      } else {
        users.addAll(response.items ?? []);
      }

      hasMore.value = response.hasMore ?? false;
      if (hasMore.value) {
        currentPage.value++;
      } else if (!refresh) {
        Get.snackbar('Info', 'No more users to load', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      if (!refresh) currentPage.value--;
      Get.snackbar('Error', 'Failed to load users: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUsers() async {
    await loadUsers(refresh: true, inname: searchQuery.value);
  }

  @override
  void onClose() {
    scrollController.dispose();
    _searchDebounce?.cancel();
    super.onClose();
  }
}
