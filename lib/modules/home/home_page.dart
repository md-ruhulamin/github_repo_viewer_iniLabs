import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repo_viewer/core/theme/theme_services.dart';
import 'package:github_repo_viewer/core/utils/data_formatter.dart';
import 'package:github_repo_viewer/modules/home/home_page_controller.dart';
import 'package:github_repo_viewer/modules/repo_details/%20repo_details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final ThemeService themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repositories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),

        actions: [
          // Theme Toggle
          IconButton(
            icon: Icon(
              themeService.isSavedDarkMode()
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              themeService.changeThemeMode();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Obx(() {
              final user = controller.user.value;
              if (user == null) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(left: 20,bottom: 20,right: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar with border
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '@${user.login}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.folder_outlined,
                          label: 'Repos',
                          value: user.publicRepos.toString(),
                        ),
                        Container(height: 40, width: 1, color: Colors.white30),
                        _buildStatItem(
                          icon: Icons.people_outline,
                          label: 'Followers',
                          value: user.followers.toString(),
                        ),
                        Container(height: 40, width: 1, color: Colors.white30),
                        _buildStatItem(
                          icon: Icons.person_add_outlined,
                          label: 'Following',
                          value: user.following.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),

          // Search and Filter Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Search Bar

                  // Filter and View Options
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                         
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A2A2A)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search repositories...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                            onChanged: controller.searchRepos,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: PopupMenuButton<SortType>(
                              offset: const Offset(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sort,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      controller.getSortLabel(
                                        controller.sortType.value,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              onSelected: controller.changeSortType,
                              itemBuilder: (context) => [
                                for (var type in SortType.values)
                                  PopupMenuItem(
                                    value: type,
                                    child: Row(
                                      children: [
                                        Obx(
                                          () => Icon(
                                            controller.sortType.value == type
                                                ? Icons.check_circle
                                                : Icons.circle_outlined,
                                            size: 20,
                                            color:
                                                controller.sortType.value ==
                                                    type
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                        //   const SizedBox(width: 12),
                                        Text(controller.getSortLabel(type)),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),

                      const SizedBox(width: 8),

                      // View Toggle
                      Expanded(
                        flex: 1,
                        child: Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: Icon(
                                controller.viewType.value == ViewType.list
                                    ? Icons.grid_view_rounded
                                    : Icons.view_list_rounded,
                                color: Colors.white,
                              ),
                              onPressed: controller.toggleView,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Repository List/Grid
          Obx(() {
            if (controller.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red.withOpacity(0.7),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Oops! Something went wrong',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: controller.fetchRepositories,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (controller.filteredRepos.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'No repositories found',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            }

            return controller.viewType.value == ViewType.list
                ? _buildListView()
                : _buildGridView();
          }),

          // Bottom Padding
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final repo = controller.filteredRepos[index];
          return _buildRepoCard(context, repo, false);
        }, childCount: controller.filteredRepos.length),
      ),
    );
  }

  Widget _buildGridView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final repo = controller.filteredRepos[index];
          return _buildRepoCard(context, repo, true);
        }, childCount: controller.filteredRepos.length),
      ),
    );
  }

  Widget _buildRepoCard(BuildContext context, repo, bool isGrid) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(-2, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(2, -2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GithubDetails(repoModel: repo),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: isGrid ? MainAxisSize.max : MainAxisSize.min,
              children: [
                // Header with Icon and Name
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.folder_outlined,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            repo.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.orange,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              repo.private ? 'Private' : 'Public',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                // Description
                if (repo.description != null && repo.description!.isNotEmpty)
                  Text(
                    repo.description!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: isGrid ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                if (isGrid) const Spacer(),

                const SizedBox(height: 5),

                Row(
                  children: [
                    // Language Tag
                    if (repo.language != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                repo.language!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                // Stats Row
                Row(
                  children: [
                    _buildStatBadge(
                      icon: Icons.star,
                      value: repo.stargazersCount.toString(),
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 12),
                    _buildStatBadge(
                      icon: Icons.fork_right,
                      value: repo.forksCount.toString(),
                      color: Colors.blue,
                    ),
                    if (repo.openIssuesCount > 0) ...[
                      const SizedBox(width: 12),
                      _buildStatBadge(
                        icon: Icons.info_outline,
                        value: repo.openIssuesCount.toString(),
                        color: Colors.green,
                      ),
                    ],
                    Spacer(),
                    if (!isGrid)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                repo.defaultBranch,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (isGrid)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            repo.defaultBranch,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  "Last Modified: ${formatDate(repo.updatedAt)}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }


}
// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   final HomeController controller = Get.put(HomeController());
//   final ThemeService themeService = ThemeService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Repositories'),
//         actions: [
//           // View Toggle
//           Obx(() {
//             return IconButton(
//               icon: Icon(
//                 controller.viewType.value == ViewType.list
//                     ? Icons.grid_view
//                     : Icons.view_list,
//               ),
//               onPressed: controller.toggleView,
//             );
//           }),
          
//           // Sort Menu
//           PopupMenuButton<SortType>(
//             icon: const Icon(Icons.sort),
//             onSelected: controller.changeSortType,
//             itemBuilder: (context) => [
//               for (var type in SortType.values)
//                 PopupMenuItem(
//                   value: type,
//                   child: Row(
//                     children: [
//                       Obx(() => Icon(
//                         controller.sortType.value == type
//                             ? Icons.check_circle
//                             : Icons.circle_outlined,
//                         size: 20,
//                         color: controller.sortType.value == type
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey,
//                       )),
//                       const SizedBox(width: 12),
//                       Text(controller.getSortLabel(type)),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
          
//           // Theme Toggle
//           IconButton(
//             icon: Icon(
//               themeService.isSavedDarkMode()
//                   ? Icons.light_mode
//                   : Icons.dark_mode,
//             ),
//             onPressed: () {
//               themeService.changeThemeMode();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // User Info Card
//           Obx(() {
//             final user = controller.user.value;
//             if (user == null) return const SizedBox.shrink();
            
//             return Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Avatar
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: NetworkImage(user.avatarUrl),
//                   ),
//                   const SizedBox(width: 16),
                  
//                   // User Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           user.name ?? user.login,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '@${user.login}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             _buildStatItem(
//                               Icons.folder,
//                               user.publicRepos.toString(),
//                             ),
//                             const SizedBox(width: 16),
//                             _buildStatItem(
//                               Icons.people,
//                               user.followers.toString(),
//                             ),
//                             const SizedBox(width: 16),
//                             _buildStatItem(
//                               Icons.person_add,
//                               user.following.toString(),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
          
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Search repositories...',
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: controller.searchRepos,
//             ),
//           ),
          
//           // Repository List/Grid
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
              
//               if (controller.errorMessage.value.isNotEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.error_outline, size: 64, color: Colors.red),
//                       const SizedBox(height: 16),
//                       Text(
//                         controller.errorMessage.value,
//                         style: const TextStyle(fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: controller.fetchRepositories,
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 );
//               }
              
//               if (controller.filteredRepos.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No repositories found',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 );
//               }
              
//               return controller.viewType.value == ViewType.list
//                   ? _buildListView()
//                   : _buildGridView();
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(IconData icon, String value) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.grey[600]),
//         const SizedBox(width: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildListView() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: controller.filteredRepos.length,
//       itemBuilder: (context, index) {
//         final repo = controller.filteredRepos[index];
//         return _buildRepoCard(context,repo, false);
//       },
//     );
//   }

//   Widget _buildGridView() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(16),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.8,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: controller.filteredRepos.length,
//       itemBuilder: (context, index) {
//         final repo = controller.filteredRepos[index];
//         return _buildRepoCard(context,repo, true);
//       },
//     );
//   }

//   Widget _buildRepoCard(BuildContext context, repo, bool isGrid) {
//     return Card(
//       margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 12),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>GithubDetails(repoModel: repo,) ));
//           // Get.snackbar(
//           //   'Coming Soon',
//           //   'Repository details will be shown here',
//           //   snackPosition: SnackPosition.BOTTOM,
//           // );
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: isGrid ? MainAxisSize.max : MainAxisSize.min,
//             children: [
//               // Repo Name
//               Row(
//                 children: [
//                   const Icon(Icons.folder, size: 20),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       repo.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
              
//               const SizedBox(height: 8),
              
//               // Description
//               if (repo.description != null && repo.description!.isNotEmpty)
//                 Text(
//                   repo.description!,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                   maxLines: isGrid ? 3 : 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
              
//               // Use Spacer only in grid view
//               if (isGrid) const Spacer(),
              
//               const SizedBox(height: 12),
              
//               // Stats
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 8,
//                 children: [
//                   if (repo.language != null)
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Get.theme.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         repo.language!,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Get.theme.primaryColor,
//                         ),
//                       ),
//                     ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.star, size: 16, color: Colors.amber),
//                       const SizedBox(width: 4),
//                       Text(
//                         repo.stargazersCount.toString(),
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.fork_right, size: 16),
//                       const SizedBox(width: 4),
//                       Text(
//                         repo.forksCount.toString(),
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }