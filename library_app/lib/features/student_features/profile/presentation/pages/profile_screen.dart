import '../../../../../core/resources/app_localization.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../core/widgets/textfield/custom_textfield.dart';
import '../widgets/profile_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool canPop;
  const ProfileScreen({super.key, this.canPop = false});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      canPop: canPop,
      screenTitle: localize("profile"),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const ProfileHeaderWidget(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  hintText: 'Date of Birth',
                  initialValue: '22 July 1996',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  hintText: 'Parent Mail ID',
                  initialValue: 'parent@gmail.com',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
          Center(
              child: Container(
                  //Initialize chart
                  child: SfCartesianChart(
                      title:
                          ChartTitle(text: 'الزمن مع معدل الاختبارات لكل يوم'),
                      legend: const Legend(isVisible: true),

                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                // Initialize line series
                LineSeries<ChartData, String>(
                    name: 'تقدم الطالب',
                    color: ColorManager.darkPrimary,
                    dataSource: [
                      // Bind data source
                      ChartData('Jan', 35),
                      ChartData('Feb', 28),
                      ChartData('Mar', 34),
                      ChartData('Apr', 32),
                      ChartData('May', 40)
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ]))),
          CustomRoundedButton(
            text: "My Results",
            onPressed: () {},
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
