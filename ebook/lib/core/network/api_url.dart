class ApiURLs {
  ///BASE URL
  static const String baseUrl = 'http://172.16.100.106/api/v1/';
  static const String loginPath = 'Account/CreateToken/';
  static const String refreshTokenPath = 'Account/refresh';
  static const String getAllBooksPath = 'Book';
  static const String getMyBooksPath = '$getAllBooksPath/MyBooks';
  static const String getReadingBookPath = '$getAllBooksPath/DownloadFile';
  static const String getTeacherAssignmentsPath = 'Assignment';
  static const String getStudentAssignmentsPath =
      '$getTeacherAssignmentsPath/MyAssignments';
  static const String getStudentsPath = 'Student/';
  static const String getClassYearPath = 'ClassYear';
  static const String getSectionGroupPath =
      '$getClassYearPath/GetAllGroupSection/';
  static const String getTeacherProfilePath = 'User/GetTeacherProfile/';
  static const String getStudentProfilePath = 'User/GetStudentProfile/';
  static const String favoriteBookPath = 'Favorite';
  static const String myFavoriteBooksPath = '$favoriteBookPath/MyFavorites/';
  static const String getIsFavoriteBookPath =
      '$favoriteBookPath/GetFavoriteByBookID';
}
