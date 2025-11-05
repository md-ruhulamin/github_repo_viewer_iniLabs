class AppConstants {
  // API URLs
  static const String baseUrl = 'https://api.github.com';
  static const String userEndpoint = '/users';
  
  // Error Messages
  static const String networkError = 'Network error. Please check your connection.';
  static const String userNotFound = 'User not found. Please check the username.';
  static const String genericError = 'Something went wrong. Please try again.';
  static const String emptyUsername = 'Please enter a username';
  
  // Storage Keys
  static const String lastUsernameKey = 'last_username';
}