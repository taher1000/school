import '../../../features/books/presentation/bloc/books_bloc.dart';
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
      // BlocProvider(create: (_) => SignInBloc(getIt())),
      BlocProvider(create: (_) => SignInBloc(getIt())),
    ],
    child: child,
  );
}
