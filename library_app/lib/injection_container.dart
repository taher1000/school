import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'features/group_section/data/datasources/group_section_datasource.dart';
import 'features/group_section/data/repositories/group_section_repository_impl.dart';
import 'features/group_section/domain/repositories/group_section_repository.dart';
import 'features/group_section/domain/usecases/get_group_section_usecase.dart';
import 'features/reader/data/datasources/reader_remote_datasource.dart';
import 'features/reader/data/repositories/reader_repository_impl.dart';
import 'features/reader/domain/repositories/reader_repository.dart';
import 'features/student_features/my_assignments/data/datasources/my_assignment_data_source.dart';
import 'features/student_features/my_assignments/data/repositories/my_assignment_repository_impl.dart';
import 'features/student_features/my_assignments/domain/repositories/my_assignment_repository.dart';
import 'features/student_features/my_assignments/domain/usecases/get_my_assignments_usecase.dart';
import 'features/student_features/my_favorites/data/datasources/my_favorite_books_data_source.dart';
import 'features/student_features/my_favorites/data/repositories/favorite_book_repository_impl.dart';
import 'features/student_features/my_favorites/domain/repositories/favorite_book_repository.dart';
import 'features/student_features/my_favorites/domain/usecases/add_favorite_book_use_case.dart';
import 'features/student_features/my_favorites/domain/usecases/is_favorite_book_use_case.dart';
import 'features/student_features/quiz/data/datasource/quiz_datasource.dart';
import 'features/student_features/quiz/data/repository/quiz_repository_impl.dart';
import 'features/student_features/quiz/domain/repositories/question_repository.dart';
import 'features/student_features/quiz/domain/usecases/finish_quiz_use_case.dart';
import 'features/student_features/quiz/domain/usecases/get_all_general_questions_use_case.dart';
import 'features/students/data/repository/student_repository_impl.dart';
import 'features/students/domain/repository/student_repository.dart';
import 'features/teacher_features/assignment/domain/usecases/add_new_assignment_usecase.dart';
import 'features/teacher_features/assignment/domain/usecases/get_assignment_by_id_usecase.dart';
import 'features/books/data/datasources/book_remote_datasource.dart';
import 'features/books/data/repositories/book_repository_impl.dart';
import 'features/books/domain/repositories/book_repository.dart';
import 'features/books/domain/usecases/get_books_usecase.dart';
import 'features/class_year/data/datasources/class_year_datasource.dart';
import 'features/class_year/data/repositories/class_year_repository_impl.dart';
import 'features/class_year/domain/repositories/class_year_repository.dart';
import 'features/class_year/domain/usecases/get_class_year_usecase.dart';
import 'features/reader/domain/usecases/save_student_book_status_use_case.dart';
import 'features/student_features/my_books/data/datasources/my_book_remote_datasource.dart';
import 'features/student_features/my_books/data/repositories/my_book_repository_impl.dart';
import 'features/student_features/my_books/domain/repositories/my_book_repository.dart';
import 'features/student_features/my_books/domain/usecases/get_my_books_usecase.dart';
import 'features/student_features/my_favorites/domain/usecases/favorite_book_use_case.dart';
import 'features/student_features/quiz/domain/usecases/get_quiz_score_use_case.dart';
import 'features/students/data/datasource/student_datasource.dart';
import 'features/students/domain/usecase/get_all_students_usecase.dart';
import 'features/teacher_features/assignment/data/datasources/assignment_datasource.dart';
import 'features/teacher_features/assignment/domain/repositories/assignment_repository.dart';
import 'features/teacher_features/assignment/domain/usecases/delete_assignment_usecase.dart';
import 'features/teacher_features/assignment/domain/usecases/get_all_follow_up_assignments_usecase.dart';
import 'features/teacher_features/assignment/domain/usecases/get_assignments_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/blocs/bloc_config/bloc_providers.dart';
import 'core/config/app_env.dart';
import 'core/config/shared_prefs_client.dart';
import 'core/network/api_config_rest.dart';
import 'core/network/idm_rest.dart';
import 'core/network/school_rest.dart';
import 'features/main/data/datasource/user_datasource.dart';
import 'features/main/data/datasource/user_profile_datasource.dart';
import 'features/main/data/repositories/user_profile_repository.dart';
import 'features/main/data/repositories/user_repository.dart';
import 'features/main/domain/repositories/user_profile_repository.dart';
import 'features/main/domain/repositories/user_repository.dart';
import 'features/main/domain/usecases/user_usecase.dart';
import 'features/sign_in/data/datasources/auth_datasource.dart';
import 'features/sign_in/data/repositories/auth_repository.dart';
import 'features/sign_in/domain/repositories/auth_repository.dart';
import 'features/sign_in/domain/usecases/auth_usecases.dart';
import 'features/teacher_features/assignment/data/repositories/assignment_repository_impl.dart';

final GetIt getIt = GetIt.instance;
final SharedPrefsClient sharedPrefsClient = getIt();

Widget setupDependencies({required Widget child}) => listOfBlocProviders(child);

Widget setupDependenciesMainScreen({required Widget child}) =>
    listOfBlocProvidersForMainScreen(child);

class DependencyInjectionInit {
  static final DependencyInjectionInit _singleton = DependencyInjectionInit._();

  factory DependencyInjectionInit() => _singleton;

  DependencyInjectionInit._();

  /// Register the Basic Singleton
  Future<void> registerSingletons() async {
    getIt.registerLazySingleton(() => appEnv);

    /// create a instance of Shared Prefs classes.
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefsClient = SharedPrefsClient(sharedPreferences);
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton(() => sharedPrefsClient);

    /// register Dio Package
    getIt.registerLazySingleton(() => Dio());
    final idmRest = IdmRest(getIt(), appEnv, enableLog: true);
    getIt.registerLazySingleton(() => idmRest);

    getIt.registerLazySingleton(() => Dio(), instanceName: "apiConfig");

    getIt.registerLazySingleton(() => Dio(), instanceName: "schoolDio");

    final apiConfig =
        ApiConfigRest(getIt.call(instanceName: "apiConfig"), enableLog: true);

    final schoolRest = SchoolRest(getIt.call(instanceName: "schoolDio"), appEnv,
        enableLog: true);

    getIt.registerLazySingleton(() => apiConfig);
    getIt.registerLazySingleton(() => SchoolRest);

    getIt.registerLazySingleton(() => Connectivity());

    //TODO: initiate use cases here

    final authUseCase = _initAuth(idmRest);
    getIt.registerLazySingleton(() => authUseCase);
    getIt.registerLazySingleton(() => schoolRest);
    final profileUseCase = _initProfile(idmRest, schoolRest);
    getIt.registerLazySingleton(() => profileUseCase);
    final getBooksUseCase = _initGetBooksUseCase(schoolRest);
    getIt.registerLazySingleton(() => getBooksUseCase);
    final getMyBooksUseCase = _initGetMyBooksUseCase(schoolRest);
    getIt.registerLazySingleton(() => getMyBooksUseCase);
    final getAssignmentsUseCase = _initGetAssignmentsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getAssignmentsUseCase);
    final getAllFollowUpAssignmentsUseCase =
        _initGetAllFollowUpAssignmentsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getAllFollowUpAssignmentsUseCase);
    final getAssignmentByIDUseCase = _initGetAssignmentByIDUseCase(schoolRest);
    getIt.registerLazySingleton(() => getAssignmentByIDUseCase);
    final deleteAssignmentUseCase = _initDeleteAssignmentUseCase(schoolRest);
    getIt.registerLazySingleton(() => deleteAssignmentUseCase);
    final getGetClassYearsUseCase = _initGetClassYearsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getGetClassYearsUseCase);
    final getGetSectionGroupsUseCase = _initGetSectionGroupsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getGetSectionGroupsUseCase);
    final getAllStudentsUseCase = _initGetAllStudentsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getAllStudentsUseCase);
    final addNewAssignmentUseCase = _initAddNewAssignmentUseCase(schoolRest);
    getIt.registerLazySingleton(() => addNewAssignmentUseCase);
    final myAssignmentUseCase = _initGetMyAssignmentsUseCase(schoolRest);
    getIt.registerLazySingleton(() => myAssignmentUseCase);
    final myFavoriteBooksUseCase = _initGetMyFavoriteBooksUseCase(schoolRest);
    getIt.registerLazySingleton(() => myFavoriteBooksUseCase);
    final addMyFavoriteBooksUseCase =
        _initAddMyFavoriteBooksUseCase(schoolRest);
    getIt.registerLazySingleton(() => addMyFavoriteBooksUseCase);
    final isFavoriteBookUseCase = _initIsFavoriteBookUseCase(schoolRest);
    getIt.registerLazySingleton(() => isFavoriteBookUseCase);
    final getAllQuestionsUseCase =
        _initGetAllGeneralQuestionsUseCase(schoolRest);
    getIt.registerLazySingleton(() => getAllQuestionsUseCase);
    final finishQuizUseCase = _initFinishQuizUseCase(schoolRest);
    getIt.registerLazySingleton(() => finishQuizUseCase);
    final getQuizScoreUseCase = _initGetQuizScoreUseCase(schoolRest);
    getIt.registerLazySingleton(() => getQuizScoreUseCase);
    final getSaveStudentBookStatusUseCase =
        _initSaveStudentBookStatusUseCase(schoolRest);
    getIt.registerLazySingleton(() => getSaveStudentBookStatusUseCase);
  }
}

/// Init Subjects UseCases
AuthenticateUseCase _initAuth(IIDMRest idmRest) {
  IAuthRemoteDataSource authDatasource;
  IAuthRepository authRepository;

  authDatasource = AuthRemoteDataSource(idmRest);

  // init repositories
  authRepository = AuthRepository(authDatasource);

  // use cases
  return AuthenticateUseCase(authRepository);
}

/// Init Subjects UseCases
ProfileDataUseCase _initProfile(IIDMRest idmRest, ISchoolRest iSchoolRest) {
  IProfileRemoteDataSource profileDatasource;
  IProfileRepository profileRepository;
  IUserRemoteDataSource userDatasource;
  IUserRepository userRepository;
  profileDatasource = ProfileRemoteDataSource(idmRest, iSchoolRest);
  userDatasource = UserRemoteDataSource(iSchoolRest);

  // init repositories
  profileRepository = ProfileRepository(profileDatasource);
  userRepository = UserRepository(userDatasource);
  // use cases
  return ProfileDataUseCase(profileRepository, userRepository);
}

GetBooksUseCase _initGetBooksUseCase(ISchoolRest iSchoolRest) {
  IBookRemoteDataSource bookDatasource;
  IBookRepository bookRepository;

  bookDatasource = BookRemoteDataSource(iSchoolRest);

  // init repositories
  bookRepository = BookRepositoryImpl(remoteDataSource: bookDatasource);
  // use cases
  return GetBooksUseCase(bookRepository);
}

GetStudentMyAssignmentsUseCase _initGetMyAssignmentsUseCase(
    ISchoolRest iSchoolRest) {
  IMyAssignmentRemoteDataSource assignmentDatasource;
  IMyAssignmentRepository assignmentRepository;

  assignmentDatasource = MyAssignmentRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  assignmentRepository =
      MyAssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return GetStudentMyAssignmentsUseCase(assignmentRepository);
}

GetMyBooksUseCase _initGetMyBooksUseCase(ISchoolRest iSchoolRest) {
  IMyBookRemoteDataSource bookDatasource;
  IMyBookRepository bookRepository;

  bookDatasource = MyBookRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  bookRepository = MyBookRepositoryImpl(remoteDataSource: bookDatasource);
  // use cases
  return GetMyBooksUseCase(bookRepository);
}

GetMyFavoriteBooksMyUseCase _initGetMyFavoriteBooksUseCase(
    ISchoolRest iSchoolRest) {
  IMyFavoriteBookRemoteDataSource favoriteBooksDatasource;
  IMyFavoriteBooksRepository favoriteBooksRepository;

  favoriteBooksDatasource = MyFavoriteBookRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  favoriteBooksRepository =
      MyFavoriteBooksRepositoryImpl(remoteDataSource: favoriteBooksDatasource);
  // use cases
  return GetMyFavoriteBooksMyUseCase(favoriteBooksRepository);
}

IsFavoriteBookUseCase _initIsFavoriteBookUseCase(ISchoolRest iSchoolRest) {
  IMyFavoriteBookRemoteDataSource favoriteBooksDatasource;
  IMyFavoriteBooksRepository favoriteBooksRepository;

  favoriteBooksDatasource = MyFavoriteBookRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  favoriteBooksRepository =
      MyFavoriteBooksRepositoryImpl(remoteDataSource: favoriteBooksDatasource);
  // use cases
  return IsFavoriteBookUseCase(favoriteBooksRepository);
}

AddMyFavoriteBookUseCase _initAddMyFavoriteBooksUseCase(
    ISchoolRest iSchoolRest) {
  IMyFavoriteBookRemoteDataSource favoriteBooksDatasource;
  IMyFavoriteBooksRepository favoriteBooksRepository;

  favoriteBooksDatasource = MyFavoriteBookRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  favoriteBooksRepository =
      MyFavoriteBooksRepositoryImpl(remoteDataSource: favoriteBooksDatasource);
  // use cases
  return AddMyFavoriteBookUseCase(favoriteBooksRepository);
}

GetAssignmentsUseCase _initGetAssignmentsUseCase(ISchoolRest iSchoolRest) {
  IAssignmentRemoteDataSource assignmentDatasource;
  IAssignmentRepository assignmentRepository;

  assignmentDatasource = AssignmentRemoteDataSource(iSchoolRest);

  // init repositories
  assignmentRepository =
      AssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return GetAssignmentsUseCase(assignmentRepository);
}

GetAllFollowUpAssignmentsUseCase _initGetAllFollowUpAssignmentsUseCase(
    ISchoolRest iSchoolRest) {
  IAssignmentRemoteDataSource assignmentDatasource;
  IAssignmentRepository assignmentRepository;

  assignmentDatasource = AssignmentRemoteDataSource(iSchoolRest);

  // init repositories
  assignmentRepository =
      AssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return GetAllFollowUpAssignmentsUseCase(assignmentRepository);
}

GetAssignmentByIDUseCase _initGetAssignmentByIDUseCase(
    ISchoolRest iSchoolRest) {
  IAssignmentRemoteDataSource assignmentDatasource;
  IAssignmentRepository assignmentRepository;

  assignmentDatasource = AssignmentRemoteDataSource(iSchoolRest);

  // init repositories
  assignmentRepository =
      AssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return GetAssignmentByIDUseCase(assignmentRepository);
}

DeleteAssignmentUseCase _initDeleteAssignmentUseCase(ISchoolRest iSchoolRest) {
  IAssignmentRemoteDataSource assignmentDatasource;
  IAssignmentRepository assignmentRepository;

  assignmentDatasource = AssignmentRemoteDataSource(iSchoolRest);

  // init repositories
  assignmentRepository =
      AssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return DeleteAssignmentUseCase(assignmentRepository);
}

GetClassYearsUseCase _initGetClassYearsUseCase(ISchoolRest iSchoolRest) {
  IClassYearRemoteDataSource bookDatasource;
  IClassYearRepository bookRepository;

  bookDatasource = ClassYearRemoteDataSource(iSchoolRest);

  // init repositories
  bookRepository = ClassYearRepositoryImpl(remoteDataSource: bookDatasource);
  // use cases
  return GetClassYearsUseCase(bookRepository);
}

GetSectionGroupsUseCase _initGetSectionGroupsUseCase(ISchoolRest iSchoolRest) {
  ISectionGroupRemoteDataSource bookDatasource;
  ISectionGroupRepository bookRepository;

  bookDatasource = SectionGroupRemoteDataSource(iSchoolRest);

  // init repositories
  bookRepository = SectionGroupRepositoryImpl(remoteDataSource: bookDatasource);
  // use cases
  return GetSectionGroupsUseCase(bookRepository);
}

GetAllStudentsUseCase _initGetAllStudentsUseCase(ISchoolRest iSchoolRest) {
  IGetAllStudentRemoteDataSource bookDatasource;
  IGetAllStudentRepository bookRepository;

  bookDatasource = GetAllStudentRemoteDataSource(iSchoolRest);

  // init repositories
  bookRepository =
      GetAllStudentRepositoryImpl(remoteDataSource: bookDatasource);
  // use cases
  return GetAllStudentsUseCase(bookRepository);
}

AddNewAssignmentUseCase _initAddNewAssignmentUseCase(ISchoolRest iSchoolRest) {
  IAssignmentRemoteDataSource assignmentDatasource;
  IAssignmentRepository assignmentRepository;

  assignmentDatasource = AssignmentRemoteDataSource(iSchoolRest);

  // init repositories
  assignmentRepository =
      AssignmentRepositoryImpl(remoteDataSource: assignmentDatasource);
  // use cases
  return AddNewAssignmentUseCase(assignmentRepository);
}

GetAllGeneralQuestionsUseCase _initGetAllGeneralQuestionsUseCase(
    ISchoolRest iSchoolRest) {
  IQuizDataSource dataSource;
  IQuizRepository quizRepository;

  dataSource = QuizDataSource(iSchoolRest);

  // init repositories
  quizRepository = QuizRepositoryImpl(remoteDataSource: dataSource);
  // use cases
  return GetAllGeneralQuestionsUseCase(quizRepository);
}

FinishQuizUseCase _initFinishQuizUseCase(ISchoolRest iSchoolRest) {
  IQuizDataSource dataSource;
  IQuizRepository quizRepository;

  dataSource = QuizDataSource(iSchoolRest);

  // init repositories
  quizRepository = QuizRepositoryImpl(remoteDataSource: dataSource);
  // use cases
  return FinishQuizUseCase(quizRepository);
}

GetQuizScoreUseCase _initGetQuizScoreUseCase(ISchoolRest iSchoolRest) {
  IQuizDataSource dataSource;
  IQuizRepository quizRepository;

  dataSource = QuizDataSource(iSchoolRest);

  // init repositories
  quizRepository = QuizRepositoryImpl(remoteDataSource: dataSource);
  // use cases
  return GetQuizScoreUseCase(quizRepository);
}

SaveStudentBookStatusUseCase _initSaveStudentBookStatusUseCase(
    ISchoolRest iSchoolRest) {
  IReaderRemoteDataSource dataSource;
  IReaderRepository readerRepository;

  dataSource = ReaderRemoteDataSourceImpl(iSchoolRest);

  // init repositories
  readerRepository = ReaderRepositoryImpl(remoteDataSource: dataSource);
  // use cases
  return SaveStudentBookStatusUseCase(readerRepository);
}
