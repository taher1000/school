import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebook/features/books/data/models/data.dart';
import 'package:ebook/features/on_boarding/on_boarding_screen.dart';
import 'package:ebook/features/profile/presentation/pages/profile_screen.dart';
import 'package:ebook/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/blocs/app_bloc/app_bloc.dart';
import 'core/blocs/bloc_config/bloc_observer.dart';
import 'core/navigation/custom_navigation.dart';
import 'core/resources/app_localization.dart';
import 'core/resources/assets_manager.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'core/widgets/popup/no_internet_pop_message.dart';
import 'core/widgets/popup/privacy_pop_message.dart';
import 'core/widgets/scaffolds/scaffold_with_background.dart';
import 'features/books/data/models/book.dart';
import 'features/books/presentation/pages/book_content.dart';
import 'features/books/presentation/pages/book_details_screen.dart';
import 'features/books/presentation/pages/books_screen.dart';
import 'features/chat/presentation/pages/chats_screen.dart';
import 'features/chat/presentation/pages/message_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/quiz/presentation/pages/quiz_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await (Connectivity().checkConnectivity());
  await DependencyInjectionInit().registerSingletons();

  Bloc.observer = AppBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: true,
        designSize: const Size(414, 896),
        builder: (BuildContext context, Widget? child) => Listener(
              onPointerDown: (_) async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  await Future.delayed(const Duration(milliseconds: 50));
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'School',
                theme: getApplicationTheme(),
                // themeMode: themeState.themeMode,
                navigatorKey: CustomNavigator.navigatorState,
                onGenerateRoute: CustomNavigator.onCreateRoute,
                navigatorObservers: [CustomNavigator.routeObserver],
                localizationsDelegates: const [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('ar', ''),
                ],
                builder: (_, c) =>
                    // ReadNovel(
                    //       data: DataNovel(
                    //         title: 'Secondry Book',
                    //         image: ImageAssets.book1,
                    //         author: 'Level 1',
                    //         rating: '4.5',
                    //         genre1: 'Fantasy',
                    //         genre2: 'Advanture',
                    //         status: 'Ongoing',
                    //         sinopsis:
                    //             '10 tahun yang lalu, setelah "Gerbang" yang menghubungkan dunia nyata dengan dunia monster dibuka, beberapa orang biasa menerima kekuatan untuk berburu monster '
                    //             'di dalam Gerbang. Mereka dikenal sebagai "Pemburu". Namun, tidak semua Pemburu kuat. Nama saya Sung Jin-Woo, '
                    //             'Hunter E-rank. Aku adalah seseorang yang harus mempertaruhkan nyawanya di ruang bawah tanah paling rendah, "Yang Terlemah di Dunia".'
                    //             'Tidak memiliki keterampilan apa pun untuk ditampilkan, saya hampir tidak mendapatkan uang yang dibutuhkan dengan bertarung di ruang bawah tanah tingkat rendah'
                    //             '... setidaknya sampai saya menemukan ruang bawah tanah tersembunyi dengan kesulitan tersulit di dalam ruang bawah tanah peringkat-D! Pada akhirnya, saat saya menerima kematian, saya tiba-tiba menerima kekuatan aneh, log pencarian yang hanya bisa saya lihat, rahasia untuk naik level yang hanya saya yang tahu! Jika saya berlatih sesuai dengan pencarian saya dan monster yang diburu, level saya akan naik. Berubah dari Hunter terlemah menjadi Hunter S-rank terkuat!',
                    //         chapter: 'Chapter 1: The Beginning',
                    //         date: '17 Februari 2019',
                    //         content: 'Hunter Kelas E,Sung Jin Woo.\n\n'
                    //             'Terlepas dari apa aku itu,aku hanyalah seorang pengikut barisan.\n'
                    //             'berbeda dari orang biasa.\n\n'
                    //             'Jadi aku selalu hidup dengan cedera.\n'
                    //             'Ada sangat banyak peristiwa dimana aku berada diantara kematian.\n'
                    //             'Tentu saja,aku tidak menjadi Hunter hanya karena aku suka.\n'
                    //             'Pekerjaan itu berbahaya,selalu diabaikan,bahkan tidak memiliki hukum.\n'
                    //             'Jika tidak ada bantuan medis untuk Hunter dari Asosiasi Hunter,aku akan berhenti jadi Hunter\n'
                    //             'dan mulai menjalani kehidupan normal.\n\n'
                    //             'Tapi sekarang,di pertengahan usia dua puluhan,Aku,Jin-woo,yang tidak memiliki keterampilan khusus,\n'
                    //             'telah menjadi pemburu untuk biaya rumah sakit ibuku yang sakit.\n'
                    //             'Bukankah kau pikir jika aku tidak ada punya pilihan lagi?\n'
                    //             'Jadi hari itu,Aku menangis dan berpartisipasi dalam Raid yang diselenggarakan oleh asosiasi\n'
                    //             'tanpa memiliki sejumlah mustard untuk dimakan.\n\n'
                    //             '*** Hunter yang bekerja di daerah yang sama biasanya saling mengenal.\n'
                    //             'Ketika Gates dibuka,para Hunter di daerah itu akan berkumpul bersama.\n'
                    //             'Pertama,para Hunter akan saling menyapa dengan menyeruput kopi hangat yang diberikan oleh staf asosiasi\n',
                    //       ),
                    //       // books: Book(
                    //       //   name: "The Secondry Book",
                    //       //   publisher: "Level 3",
                    //       //   image: ImageAssets.book1,
                    //       //   like: false,
                    //       // ),
                    //     )
                    BooksScreen(),
              ),
            ));
    // BlocProvider(
    //   create: (_) => AppBloc(
    //     getIt(),
    //   ),
    // child:

    //   setupDependencies(
    //     child: BlocBuilder<LanguageCubit, LanguageState>(
    //       buildWhen: (previousState, currentState) =>
    //           previousState != currentState,
    //       builder: (_, localeState) {
    //         return BlocBuilder<AppThemeCubit, AppThemeState>(
    //           builder: (_, themeState) {
    // return ScreenUtilInit(
    //     splitScreenMode: true,
    //     designSize: const Size(414, 896),
    //     builder: (BuildContext context, Widget? child) => Listener(
    //           onPointerDown: (_) async {
    //             FocusScopeNode currentFocus =
    //                 FocusScope.of(context);
    //             if (!currentFocus.hasPrimaryFocus &&
    //                 currentFocus.focusedChild != null) {
    //               await Future.delayed(
    //                   const Duration(milliseconds: 50));
    //               currentFocus.focusedChild?.unfocus();
    //             }
    //           },
    //           child: MaterialApp(
    //               debugShowCheckedModeBanner: false,
    //               title: 'EZENESS',
    //               theme: getApplicationTheme(),
    //               themeMode: themeState.themeMode,
    //               navigatorKey: CustomNavigator.navigatorState,
    //               onGenerateRoute: CustomNavigator.onCreateRoute,
    //               navigatorObservers: [
    //                 CustomNavigator.routeObserver
    //               ],
    //               localizationsDelegates: const [
    //                 AppLocalization.delegate,
    //                 GlobalMaterialLocalizations.delegate,
    //                 GlobalWidgetsLocalizations.delegate,
    //                 GlobalCupertinoLocalizations.delegate,
    //               ],
    //               supportedLocales: const [
    //                 Locale('en', ''),
    //                 Locale('ar', ''),
    //               ],
    //               builder: (_, c) =>
    //               _AppBuilder(c),
    //               ),
    //         ));
    //           },
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

class _AppBuilder extends StatefulWidget {
  final Widget? child;

  const _AppBuilder(this.child);

  @override
  State<_AppBuilder> createState() => _AppBuilderState();
}

class _AppBuilderState extends State<_AppBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // MainScreen();
        BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is UserAuthState) {
          switch (state.userAuthStatus) {
            /// SignedIn Status
            case UserAuthStatus.signedIn:
              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// SignedIn Status

            /// Signed out Status
            case UserAuthStatus.signedOut:
              await sharedPrefsClient.clearUserData();

              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// User need force update

            /// First Time as a Login for User
            case UserAuthStatus.firstTimeLogin:
              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// User has no internet connection.
            case UserAuthStatus.userHasNoInternetConnection:
              showDialog(
                  useSafeArea: false,
                  context: currentContext!,
                  builder: (context) => const NoInternetPopMessage(),
                  barrierDismissible: false);
              break;

            /// User Should Agree Privacy
            case UserAuthStatus.userShouldAgreePrivacy:
              showCupertinoModalPopup(
                  context: currentContext!,
                  builder: (context) => const PrivacyPopMessage(),
                  barrierDismissible: false);
              break;

            /// User Should Agree Privacy
            case UserAuthStatus.userAgreePrivacyMessage:
              CustomNavigator.pop();
              break;
            case UserAuthStatus.userNeedUpdate:
              // TODO: Handle this case.
              break;
            case UserAuthStatus.updateMobileDate:
              // TODO: Handle this case.
              break;
          }
        }
      },
      child: widget.child,
    );
  }
}
