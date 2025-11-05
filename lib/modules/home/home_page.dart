import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repo_viewer/core/theme/theme_services.dart';
import 'package:github_repo_viewer/modules/home/home_page_controller.dart';
import 'package:github_repo_viewer/modules/repo_details/%20repo_details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final ThemeService themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repositories'),
        actions: [
          // View Toggle
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.viewType.value == ViewType.list
                    ? Icons.grid_view
                    : Icons.view_list,
              ),
              onPressed: controller.toggleView,
            );
          }),
          
          // Sort Menu
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort),
            onSelected: controller.changeSortType,
            itemBuilder: (context) => [
              for (var type in SortType.values)
                PopupMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Obx(() => Icon(
                        controller.sortType.value == type
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        size: 20,
                        color: controller.sortType.value == type
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      )),
                      const SizedBox(width: 12),
                      Text(controller.getSortLabel(type)),
                    ],
                  ),
                ),
            ],
          ),
          
          // Theme Toggle
          IconButton(
            icon: Icon(
              themeService.isSavedDarkMode()
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeService.changeThemeMode();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // User Info Card
          Obx(() {
            final user = controller.user.value;
            if (user == null) return const SizedBox.shrink();
            
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(width: 16),
                  
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? user.login,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${user.login}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildStatItem(
                              Icons.folder,
                              user.publicRepos.toString(),
                            ),
                            const SizedBox(width: 16),
                            _buildStatItem(
                              Icons.people,
                              user.followers.toString(),
                            ),
                            const SizedBox(width: 16),
                            _buildStatItem(
                              Icons.person_add,
                              user.following.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search repositories...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.searchRepos,
            ),
          ),
          
          // Repository List/Grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        controller.errorMessage.value,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.fetchRepositories,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              
              if (controller.filteredRepos.isEmpty) {
                return const Center(
                  child: Text(
                    'No repositories found',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              
              return controller.viewType.value == ViewType.list
                  ? _buildListView()
                  : _buildGridView();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.filteredRepos.length,
      itemBuilder: (context, index) {
        final repo = controller.filteredRepos[index];
        return _buildRepoCard(context,repo, false);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: controller.filteredRepos.length,
      itemBuilder: (context, index) {
        final repo = controller.filteredRepos[index];
        return _buildRepoCard(context,repo, true);
      },
    );
  }

  Widget _buildRepoCard(BuildContext context, repo, bool isGrid) {
    return Card(
      margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GithubDetails(repoModel: repo,) ));
          // Get.snackbar(
          //   'Coming Soon',
          //   'Repository details will be shown here',
          //   snackPosition: SnackPosition.BOTTOM,
          // );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: isGrid ? MainAxisSize.max : MainAxisSize.min,
            children: [
              // Repo Name
              Row(
                children: [
                  const Icon(Icons.folder, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      repo.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Description
              if (repo.description != null && repo.description!.isNotEmpty)
                Text(
                  repo.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: isGrid ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
              
              // Use Spacer only in grid view
              if (isGrid) const Spacer(),
              
              const SizedBox(height: 12),
              
              // Stats
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  if (repo.language != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        repo.language!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        repo.stargazersCount.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.fork_right, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        repo.forksCount.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}