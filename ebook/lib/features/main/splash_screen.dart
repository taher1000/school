import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/resources/assets_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/blocs/app_bloc/app_bloc.dart';
import '../../core/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final Tween<double> _rotationTween = Tween(begin: 0, end: 2);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final Connectivity _connectivity = Connectivity();
  ConnectivityResult connectionState = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    _connectivity.checkConnectivity().then((value) {
      connectionState = value;
      if (value == ConnectivityResult.none) {
        context.read<AppBloc>().add(UpdateAuthAppEvent(
            userAuthStatus: UserAuthStatus.userHasNoInternetConnection));
      }
    });
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 4,
      duration: const Duration(seconds: 1),
    );
    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          controller.stop();

          // CustomNavigator.push(Routes.MAIN_SCREEN, clean: true);
          if (connectionState == ConnectivityResult.none) {
            context.read<AppBloc>().add(UpdateAuthAppEvent(
                userAuthStatus: UserAuthStatus.userHasNoInternetConnection));
          }
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            left: -controller.value * 0.15.sw,
            right: -controller.value * 0.25.sw,
            bottom: controller.value * 0.025.sh,
            top: controller.value * 0.025.sh,
            duration: const Duration(milliseconds: 60),
            child: SvgPicture.asset(SvgAssets.boyImage),
          ),
          const AppLogo(
            width: 233,
            height: 128,
          ),
        ],
      ),
    );
  }
}
