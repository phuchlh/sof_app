import 'package:get/get.dart';
import 'package:sof_app/models/user_model.dart';
import 'package:sof_app/service/user_service.dart';

class UserPageController extends GetxController {
  final UserService _userService = UserService();

  // Observable variables
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;

  @override
  void onInit() {
    loadUsers();
    super.onInit();
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
}
