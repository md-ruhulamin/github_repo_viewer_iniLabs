import 'package:get/get.dart';
import 'package:github_repo_viewer/data/services.dart/github_api_service.dart';
import '../../data/models/user_model.dart';
import '../../data/models/repo_model.dart';


enum ViewType { list, grid }
enum SortType { name, date, stars, forks }

class HomeController extends GetxController {
  final GithubApiService _apiService = GithubApiService();
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxList<RepoModel> allRepos = <RepoModel>[].obs;
  final RxList<RepoModel> filteredRepos = <RepoModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<ViewType> viewType = ViewType.list.obs;
  final Rx<SortType> sortType = SortType.date.obs;

  @override
  void onInit() {
    super.onInit();
    final UserModel? userArg = Get.arguments;
    if (userArg != null) {
      user.value = userArg;
      fetchRepositories();
    }
  }

  Future<void> fetchRepositories() async {
    if (user.value == null) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final repos = await _apiService.getUserRepos(user.value!.login);
      allRepos.value = repos;
      applySorting();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() {
    viewType.value = viewType.value == ViewType.list ? ViewType.grid : ViewType.list;
  }

  void changeSortType(SortType type) {
    sortType.value = type;
    applySorting();
  }

  void applySorting() {
    List<RepoModel> sorted = List.from(allRepos);
    
    switch (sortType.value) {
      case SortType.name:
        sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortType.date:
        sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case SortType.stars:
        sorted.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
        break;
      case SortType.forks:
        sorted.sort((a, b) => b.forksCount.compareTo(a.forksCount));
        break;
    }
    
    filteredRepos.value = sorted;
  }

  void searchRepos(String query) {
    if (query.isEmpty) {
      applySorting();
      return;
    }

    filteredRepos.value = allRepos.where((repo) {
      return repo.name.toLowerCase().contains(query.toLowerCase()) ||
          (repo.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();
  }

  String getSortLabel(SortType type) {
    switch (type) {
      case SortType.name:
        return 'Name';
      case SortType.date:
        return 'Updated';
      case SortType.stars:
        return 'Stars';
      case SortType.forks:
        return 'Forks';
    }
  }
}