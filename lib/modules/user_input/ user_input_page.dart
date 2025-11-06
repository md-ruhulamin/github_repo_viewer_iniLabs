import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repo_viewer/core/theme/theme_services.dart';
import 'user_input_controller.dart';

class UserInputPage extends StatelessWidget {
  UserInputPage({super.key});

  final UserInputController controller = Get.put(UserInputController());
  final ThemeService themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                themeService.isSavedDarkMode()
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: 28,
              ),
              onPressed: () {
                themeService.changeThemeMode();
              },
            ),
          ),SizedBox(width: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
           
            children: [
            SizedBox(height: 30,),
              // GitHub Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.code, size: 50, color: Colors.white),
              ),
        
              const SizedBox(height: 32),
        
              // Title
              Text(
                'GitHub Repository Viewer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
        
              const SizedBox(height: 16),
        
              // Subtitle
              Text(
                'Enter a GitHub username to explore repositories',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
        
              const SizedBox(height: 15),
        
              // Username Input
              TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter GitHub username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                onChanged: (_) => controller.clearError(),
                onSubmitted: (_) => controller.searchUser(),
              ),
        
              const SizedBox(height: 10),
        
              // Error Message
              Obx(() {
                if (controller.errorMessage.value.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
        
              const SizedBox(height: 5),
        
              // Search Button
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.searchUser,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Search'),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
