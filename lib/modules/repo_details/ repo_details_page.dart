import 'package:flutter/material.dart';
import 'package:github_repo_viewer/data/models/repo_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubDetails extends StatelessWidget {
  final RepoModel repoModel;

  const GithubDetails({super.key, required this.repoModel});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                repoModel.name,
                style: TextStyle(
                  color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Repo Name Card
                  _buildInfoCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.folder_outlined,
                              color: const Color(0xFF3AA1EE),
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    repoModel.fullName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
                                    ),
                                  ),
                                  if (repoModel.private)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
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
                                      child: const Text(
                                        'Private',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (repoModel.description != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            repoModel.description!,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark ? const Color(0xFFE0E0E0).withOpacity(0.8) : const Color(0xFF757575),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.star_border,
                          label: 'Stars',
                          value: _formatNumber(repoModel.stargazersCount),
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.remove_red_eye_outlined,
                          label: 'Watchers',
                          value: _formatNumber(repoModel.watchersCount),
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.call_split,
                          label: 'Forks',
                          value: _formatNumber(repoModel.forksCount),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Repository Info
                  _buildInfoCard(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Repository Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (repoModel.language != null)
                          _buildInfoRow(
                            context,
                            icon: Icons.code,
                            label: 'Language',
                            value: repoModel.language!,
                          ),
                        if (repoModel.language != null) const SizedBox(height: 12),
                        _buildInfoRow(
                          context,
                          icon: Icons.bug_report_outlined,
                          label: 'Open Issues',
                          value: _formatNumber(repoModel.openIssuesCount),
                        ),
                        const SizedBox(height: 12),
                        if (repoModel.defaultBranch != null)
                          _buildInfoRow(
                            context,
                            icon: Icons.account_tree,
                            label: 'Default Branch',
                            value: repoModel.defaultBranch!,
                          ),
                        if (repoModel.defaultBranch != null) const SizedBox(height: 12),
                        _buildInfoRow(
                          context,
                          icon: Icons.calendar_today,
                          label: 'Created',
                          value: _formatDate(repoModel.createdAt),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          context,
                          icon: Icons.update,
                          label: 'Last Updated',
                          value: _formatDate(repoModel.updatedAt),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // View on GitHub Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl(repoModel.htmlUrl),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('View on GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3AA1EE),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFFE0E0E0).withOpacity(0.6) : const Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF3AA1EE),
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE0E0E0).withOpacity(0.7) : const Color(0xFF757575),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}