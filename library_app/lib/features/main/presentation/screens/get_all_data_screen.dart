import '../../splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/routes_manager.dart';
import '../bloc/user_data_bloc.dart';

class GetAllDataScreen extends StatefulWidget {
  const GetAllDataScreen({Key? key}) : super(key: key);

  @override
  State<GetAllDataScreen> createState() => _GetAllDataScreenState();
}

class _GetAllDataScreenState extends State<GetAllDataScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataBloc>().add(GetAllData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserDataBloc, UserDataState>(
        listener: (previous, current) {
          if (current is GetAllDataSuccess || current is GetAllDataFailed) {
            CustomNavigator.push(Routes.mainRoute, clean: true);
          }
        },
        listenWhen: (previous, current) {
          return current is GetAllDataLoading ||
              current is GetAllDataSuccess ||
              current is GetAllDataFailed;
        },
        buildWhen: (previous, current) {
          return current is GetAllDataLoading ||
              current is GetAllDataSuccess ||
              current is GetAllDataFailed;
        },
        builder: (context, state) {
          if (state is GetAllDataLoading) {
            return const SplashScreen();
            //  Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       height: 0.05.sh,
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 0.01.sw,
            //       ),
            //       child: Image.asset(
            //         "assets/images/simple_loading.gif",
            //         height: 0.15.sw,
            //         width: 0.15.sw,
            //       ),
            //     ),
            //   ],
            // );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
