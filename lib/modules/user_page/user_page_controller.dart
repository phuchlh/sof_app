import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sof_app/models/user_model.dart';
import 'package:sof_app/service/user_service.dart';
import 'package:intl/intl.dart';

class UserPageController extends GetxController {
  final UserService _userService = UserService();
  final _storage = GetStorage();
  static const String _bookmarkKey = 'bookmarked_users';

  final scrollController = ScrollController();

  // Observable variables
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxList<int> bookmarkedUserIds = <int>[].obs;
  final RxInt selectedToggleIndex = 0.obs;
  final RxBool showBookmarkedOnly = false.obs;

  @override
  void onInit() {
    _loadBookmarkedUsers();
    loadUsers();
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      if (!isLoading.value && hasMore.value) {
        print('Loading more users...');
        loadUsers();
      }
    }
  }

  void _loadBookmarkedUsers() {
    final List<dynamic> storedIds =
        _storage.read<List<dynamic>>(_bookmarkKey) ?? [];
    bookmarkedUserIds.value = storedIds.map((id) => id as int).toList();
  }

  void _saveBookmarkedUsers() {
    _storage.write(_bookmarkKey, bookmarkedUserIds);
  }

  bool isBookmarked(int userId) {
    return bookmarkedUserIds.contains(userId);
  }

  void toggleBookmark(UserModel user) {
    if (isBookmarked(user.userId ?? 0)) {
      bookmarkedUserIds.remove(user.userId);
    } else {
      bookmarkedUserIds.add(user.userId ?? 0);
    }
    _saveBookmarkedUsers();
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
  }) async {
    // If already loading or no more data to load (except for refresh), return
    if (isLoading.value) return;
    if (!hasMore.value && !refresh) return;

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
      );

      if (refresh) {
        users.value = response.items ?? [];
      } else {
        users.addAll(response.items ?? []);
      }

      // Update hasMore based on API response
      hasMore.value = response.hasMore ?? false;

      // Only increment page after successful load and if there's more data
      if (hasMore.value) {
        currentPage.value++;
      }

      // If no more data, show a message
      if (!hasMore.value && !refresh) {
        Get.snackbar(
          'Info',
          'No more users to load',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // If error occurs, decrement page number to retry next time
      if (!refresh) {
        currentPage.value--;
      }
      Get.snackbar(
        'Error',
        'Failed to load users: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUsers({
    String order = 'desc',
    String sort = 'reputation',
    String site = 'stackoverflow',
  }) async {
    await loadUsers(refresh: true, order: order, sort: sort, site: site);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
