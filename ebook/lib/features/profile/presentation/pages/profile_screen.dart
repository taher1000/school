import 'package:ebook/core/widgets/custome_textfield.dart';
import 'package:ebook/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "My Profile",
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
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
              SizedBox(
                width: 180.w,
                height: 80.h,
                child: CustomTextField(
                  labelText: 'ID No.',
                  initialValue: 'Taher Fawaz',
                  enabled: false,
                  suffixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
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
