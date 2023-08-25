class ApiURLs {
  ///BASE URL
  static const String baseUrl = 'http://172.16.100.106/api/v1/';
  static const String loginPath = 'Account/CreateToken/';
  static const String refreshTokenPath = 'Account/refresh';
  static const String getAllBooksPath = 'Book/';
  static const String getMyBooksPath = 'Book/MyBooks';
  static const String getTeacherAssignmentsPath = 'Assignment/';
  static const String getStudentAssignmentsPath = 'Assignment/MyAssignments';
  static const String getStudentsPath = 'Student/';
  static const String getClassYearPath = 'ClassYear/';
  static const String getSectionGroupPath = 'ClassRoom/GetAllGroupSection/';
  static const String getTeacherProfilePath = 'User/GetTeacherProfile/';
  static const String getStudentProfilePath = 'User/GetStudentProfile/';
  static const String myFavoritesPath = 'Favorite/MyFavorites/';
}
