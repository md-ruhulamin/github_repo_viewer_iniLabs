import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_repo_viewer/core/utils/constant.dart';
import 'package:github_repo_viewer/data/services.dart/github_api_service.dart';
import '../home/home_page.dart';

class UserInputController extends GetxController {
  final GithubApiService _apiService = GithubApiService();
  final _box = GetStorage();

  final TextEditingController usernameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load last username if available
    final lastUsername = _box.read(AppConstants.lastUsernameKey);
    if (lastUsername != null) {
      usernameController.text = lastUsername;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }

  void clearError() {
    errorMessage.value = '';
  }

  Future<void> searchUser() async {
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      errorMessage.value = AppConstants.emptyUsername;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userInfo = await _apiService.getUserInfo(username);

      // Save username for future use
      _box.write(AppConstants.lastUsernameKey, username);

      // Navigate to home page with user info
      Get.to(() => HomePage(), arguments: userInfo);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
