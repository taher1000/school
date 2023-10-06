import 'package:library_app/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';

import '../../../features/books/presentation/bloc/books_bloc.dart';
import '../../../features/student_features/my_books/presentation/bloc/my_books_bloc.dart';
import '../../../features/student_features/my_favorites/presentation/bloc/my_favorites_bloc.dart';
import '../../../features/student_features/my_student_profile/presentation/bloc/my_student_profile_bloc.dart';
import '../../../features/teacher_features/assignment/presentation/bloc/assignment_bloc.dart';
import '../../../features/teacher_features/my_teacher_profile/presentation/bloc/my_teacher_profile_bloc.dart';
import '../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/main/presentation/bloc/user_data_bloc.dart';
import '../../../features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../app_bloc/app_bloc.dart';
import '../app_theme_cubit/app_theme_cubit.dart';
import '../language_cubit/language_cubit.dart';

MultiBlocProvider listOfBlocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LanguageCubit(), lazy: false),
      BlocProvider(
        create: (_) => AppThemeCubit(),
      ),
      BlocProvider(create: (_) => SignInBloc(getIt())),
      // BlocProvider(create: (_) => AppBloc(getIt())),
      BlocProvider(create: (_) => UserDataBloc(getIt())), //getit
    ],
    child: child,
  );
}

MultiBlocProvider listOfBlocProvidersForMainScreen(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => BooksBloc(getIt())),
      BlocProvider(create: (_) => AssignmentBloc(getIt())),
      BlocProvider(create: (_) => MyFavoritesBloc(getIt())),
      BlocProvider(create: (_) => MyTeacherProfileBloc(getIt())),
      BlocProvider(create: (_) => MyStudentProfileBloc(getIt())),
      BlocProvider(create: (_) => MyBooksBloc(getIt())),
      BlocProvider(create: (_) => MyAssignmentsBloc(getIt())),
    ],
    child: child,
  );
}
