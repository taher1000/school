class ApiURLs {
  ///BASE URL
  static const String baseUrl = 'http://172.16.100.106/api/v1/';
  static const String loginPath = 'Account/CreateToken/';
  static const String refreshTokenPath = 'Account/refresh';
  static const String getAllBooksPath = 'Book';
  static const String saveStudentBookStatusPath =
      '$getAllBooksPath/SaveStudentBookStatus';
  static const String getContentByBookID =
      '$getAllBooksPath/GetContentByBookID';
  static const String getMyBooksPath = '$getAllBooksPath/MyBooks';
  static const String getReadingBookPath = '$getAllBooksPath/DownloadFile';
  static const String getTeacherAssignmentsPath = 'Assignment';
  static const String getAllFollowUpAssignmentsPath =
      '$getTeacherAssignmentsPath/GetAllFollowUp';
  static const String getStudentAssignmentsPath =
      '$getTeacherAssignmentsPath/MyAssignments';
  static const String getQuizPath = 'Question';
  static const String getGeneralQuestionPath =
      '$getQuizPath/GetGeneralQuestion';
  static const String getDeductiveQuestionPath =
      '$getQuizPath/GetDeductiveQuestion';
  static const String getEvaluativeQuestionPath =
      '$getQuizPath/GetEvaluativeQuestion';
  static const String getFinishQuizPath = '$getQuizPath/PostQuestionAnswer';
  static const String getQuizResultPath = '$getQuizPath/GetQuizResult';
  static const String getStudentsPath = 'Student';
  static const String getClassYearPath = 'ClassRoom/GetClassYear';
  static const String getSectionGroupPath = 'ClassRoom/GetClassSection';
  static const String getTeacherProfilePath = 'User/GetUserProfile/';
  static const String getStudentProfilePath = 'User/GetUserProfile/';
  static const String favoriteBookPath = 'Favorite';
  static const String myFavoriteBooksPath = '$favoriteBookPath/MyFavorites/';
  static const String getIsFavoriteBookPath =
      '$favoriteBookPath/GetFavoriteByBookID';
  static const String getAssignmentStatisticsPath =
      'Statistic/GetAssignmentStats';
}
