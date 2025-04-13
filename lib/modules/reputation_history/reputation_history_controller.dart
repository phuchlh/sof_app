import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/reputation_model.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';

class ReputationHistoryController extends GetxController {
  final UserService _userService = UserService();
  final scrollController = ScrollController();
  final Rx<UserModel> userModel = UserModel().obs;

  // Observable variables
  final RxList<ReputationModel> reputationHistory = <ReputationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxInt selectedUserId = 0.obs;

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      if (!isLoading.value && hasMore.value) {
        loadReputationHistory();
      }
    }
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

      if (refresh) {
        reputationHistory.value = response.items ?? [];
      } else {
        reputationHistory.addAll(response.items ?? []);
      }

      hasMore.value = response.hasMore ?? false;

      if (hasMore.value) {
        currentPage.value++;
      }

      if (!hasMore.value && !refresh) {
        Get.snackbar(
          'Info',
          'No more reputation history to load',
          snackPosition: SnackPosition.BOTTOM,
        );
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
    }
  }

  Future<void> refreshReputationHistory({int? userId}) async {
    await loadReputationHistory(refresh: true, userId: userId);
  }

  void setSelectedUserId(int userId) {
    selectedUserId.value = userId;
    refreshReputationHistory(userId: userId);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
