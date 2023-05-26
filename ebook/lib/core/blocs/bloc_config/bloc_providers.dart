import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../app_theme_cubit/app_theme_cubit.dart';
import '../language_cubit/language_cubit.dart';

MultiBlocProvider listOfBlocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LanguageCubit(), lazy: false),
      BlocProvider(
        create: (_) => AppThemeCubit(),
      ),
    ],
    child: child,
  );
}

MultiBlocProvider listOfBlocProvidersForMainScreen(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => SignInBloc()),
    ],
    child: child,
  );
}
