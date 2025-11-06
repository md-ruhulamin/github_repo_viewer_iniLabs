class UserModel {
  String? _login;
  int? _id;
  String? _nodeId;
  String? _avatarUrl;
  String? _gravatarId;
  String? _url;
  String? _htmlUrl;
  String? _followersUrl;
  String? _followingUrl;
  String? _gistsUrl;
  String? _starredUrl;
  String? _subscriptionsUrl;
  String? _organizationsUrl;
  String? _reposUrl;
  String? _eventsUrl;
  String? _receivedEventsUrl;
  String? _type;
  String? _userViewType;
  bool? _siteAdmin;
  String? _name;
  Null _company;
  String? _blog;
  String? _location;
  Null _email;
  Null _hireable;
  String? _bio;
  Null _twitterUsername;
  int? _publicRepos;
  int? _publicGists;
  int? _followers;
  int? _following;
  String? _createdAt;
  String? _updatedAt;

  UserModel(
      {String? login,
      int? id,
      String? nodeId,
      String? avatarUrl,
      String? gravatarId,
      String? url,
      String? htmlUrl,
      String? followersUrl,
      String? followingUrl,
      String? gistsUrl,
      String? starredUrl,
      String? subscriptionsUrl,
      String? organizationsUrl,
      String? reposUrl,
      String? eventsUrl,
      String? receivedEventsUrl,
      String? type,
      String? userViewType,
      bool? siteAdmin,
      String? name,
      Null company,
      String? blog,
      String? location,
      Null email,
      Null hireable,
      String? bio,
      Null twitterUsername,
      int? publicRepos,
      int? publicGists,
      int? followers,
      int? following,
      String? createdAt,
      String? updatedAt}) {
    if (login != null) {
      _login = login;
    }
    if (id != null) {
      _id = id;
    }
    if (nodeId != null) {
      _nodeId = nodeId;
    }
    if (avatarUrl != null) {
      _avatarUrl = avatarUrl;
    }
    if (gravatarId != null) {
      _gravatarId = gravatarId;
    }
    if (url != null) {
      _url = url;
    }
    if (htmlUrl != null) {
      _htmlUrl = htmlUrl;
    }
    if (followersUrl != null) {
      _followersUrl = followersUrl;
    }
    if (followingUrl != null) {
      _followingUrl = followingUrl;
    }
    if (gistsUrl != null) {
      _gistsUrl = gistsUrl;
    }
    if (starredUrl != null) {
      _starredUrl = starredUrl;
    }
    if (subscriptionsUrl != null) {
      _subscriptionsUrl = subscriptionsUrl;
    }
    if (organizationsUrl != null) {
      _organizationsUrl = organizationsUrl;
    }
    if (reposUrl != null) {
      _reposUrl = reposUrl;
    }
    if (eventsUrl != null) {
      _eventsUrl = eventsUrl;
    }
    if (receivedEventsUrl != null) {
      _receivedEventsUrl = receivedEventsUrl;
    }
    if (type != null) {
      _type = type;
    }
    if (userViewType != null) {
      _userViewType = userViewType;
    }
    if (siteAdmin != null) {
      _siteAdmin = siteAdmin;
    }
    if (name != null) {
      _name = name;
    }
    if (blog != null) {
      _blog = blog;
    }
    if (location != null) {
      _location = location;
    }
    if (bio != null) {
      _bio = bio;
    }
    if (publicRepos != null) {
      _publicRepos = publicRepos;
    }
    if (publicGists != null) {
      _publicGists = publicGists;
    }
    if (followers != null) {
      _followers = followers;
    }
    if (following != null) {
      _following = following;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  String? get login => _login;
  set login(String? login) => _login = login;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nodeId => _nodeId;
  set nodeId(String? nodeId) => _nodeId = nodeId;
  String? get avatarUrl => _avatarUrl;
  set avatarUrl(String? avatarUrl) => _avatarUrl = avatarUrl;
  String? get gravatarId => _gravatarId;
  set gravatarId(String? gravatarId) => _gravatarId = gravatarId;
  String? get url => _url;
  set url(String? url) => _url = url;
  String? get htmlUrl => _htmlUrl;
  set htmlUrl(String? htmlUrl) => _htmlUrl = htmlUrl;
  String? get followersUrl => _followersUrl;
  set followersUrl(String? followersUrl) => _followersUrl = followersUrl;
  String? get followingUrl => _followingUrl;
  set followingUrl(String? followingUrl) => _followingUrl = followingUrl;
  String? get gistsUrl => _gistsUrl;
  set gistsUrl(String? gistsUrl) => _gistsUrl = gistsUrl;
  String? get starredUrl => _starredUrl;
  set starredUrl(String? starredUrl) => _starredUrl = starredUrl;
  String? get subscriptionsUrl => _subscriptionsUrl;
  set subscriptionsUrl(String? subscriptionsUrl) =>
      _subscriptionsUrl = subscriptionsUrl;
  String? get organizationsUrl => _organizationsUrl;
  set organizationsUrl(String? organizationsUrl) =>
      _organizationsUrl = organizationsUrl;
  String? get reposUrl => _reposUrl;
  set reposUrl(String? reposUrl) => _reposUrl = reposUrl;
  String? get eventsUrl => _eventsUrl;
  set eventsUrl(String? eventsUrl) => _eventsUrl = eventsUrl;
  String? get receivedEventsUrl => _receivedEventsUrl;
  set receivedEventsUrl(String? receivedEventsUrl) =>
      _receivedEventsUrl = receivedEventsUrl;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get userViewType => _userViewType;
  set userViewType(String? userViewType) => _userViewType = userViewType;
  bool? get siteAdmin => _siteAdmin;
  set siteAdmin(bool? siteAdmin) => _siteAdmin = siteAdmin;
  String? get name => _name;
  set name(String? name) => _name = name;
  Null get company => _company;
  set company(Null company) => _company = company;
  String? get blog => _blog;
  set blog(String? blog) => _blog = blog;
  String? get location => _location;
  set location(String? location) => _location = location;
  Null get email => _email;
  set email(Null email) => _email = email;
  Null get hireable => _hireable;
  set hireable(Null hireable) => _hireable = hireable;
  String? get bio => _bio;
  set bio(String? bio) => _bio = bio;
  Null get twitterUsername => _twitterUsername;
  set twitterUsername(Null twitterUsername) =>
      _twitterUsername = twitterUsername;
  int? get publicRepos => _publicRepos;
  set publicRepos(int? publicRepos) => _publicRepos = publicRepos;
  int? get publicGists => _publicGists;
  set publicGists(int? publicGists) => _publicGists = publicGists;
  int? get followers => _followers;
  set followers(int? followers) => _followers = followers;
  int? get following => _following;
  set following(int? following) => _following = following;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  UserModel.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _id = json['id'];
    _nodeId = json['node_id'];
    _avatarUrl = json['avatar_url'];
    _gravatarId = json['gravatar_id'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _followersUrl = json['followers_url'];
    _followingUrl = json['following_url'];
    _gistsUrl = json['gists_url'];
    _starredUrl = json['starred_url'];
    _subscriptionsUrl = json['subscriptions_url'];
    _organizationsUrl = json['organizations_url'];
    _reposUrl = json['repos_url'];
    _eventsUrl = json['events_url'];
    _receivedEventsUrl = json['received_events_url'];
    _type = json['type'];
    _userViewType = json['user_view_type'];
    _siteAdmin = json['site_admin'];
    _name = json['name'];
    _company = json['company'];
    _blog = json['blog'];
    _location = json['location'];
    _email = json['email'];
    _hireable = json['hireable'];
    _bio = json['bio'];
    _twitterUsername = json['twitter_username'];
    _publicRepos = json['public_repos'];
    _publicGists = json['public_gists'];
    _followers = json['followers'];
    _following = json['following'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = _login;
    data['id'] = _id;
    data['node_id'] = _nodeId;
    data['avatar_url'] = _avatarUrl;
    data['gravatar_id'] = _gravatarId;
    data['url'] = _url;
    data['html_url'] = _htmlUrl;
    data['followers_url'] = _followersUrl;
    data['following_url'] = _followingUrl;
    data['gists_url'] = _gistsUrl;
    data['starred_url'] = _starredUrl;
    data['subscriptions_url'] = _subscriptionsUrl;
    data['organizations_url'] = _organizationsUrl;
    data['repos_url'] = _reposUrl;
    data['events_url'] = _eventsUrl;
    data['received_events_url'] = _receivedEventsUrl;
    data['type'] = _type;
    data['user_view_type'] = _userViewType;
    data['site_admin'] = _siteAdmin;
    data['name'] = _name;
    data['company'] = _company;
    data['blog'] = _blog;
    data['location'] = _location;
    data['email'] = _email;
    data['hireable'] = _hireable;
    data['bio'] = _bio;
    data['twitter_username'] = _twitterUsername;
    data['public_repos'] = _publicRepos;
    data['public_gists'] = _publicGists;
    data['followers'] = _followers;
    data['following'] = _following;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
