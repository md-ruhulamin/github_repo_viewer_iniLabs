import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_repo_viewer/core/theme/app_theme.dart';
import 'package:github_repo_viewer/core/theme/theme_services.dart';
import 'package:github_repo_viewer/modules/user_input/%20user_input_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GitHub Repo Viewer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService().getThemeMode(),
      home: UserInputPage(),
    );
  }
}