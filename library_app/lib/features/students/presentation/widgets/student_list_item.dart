import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/values_manager.dart';

class StudentCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Widget leading;
  const StudentCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onTap,
      required this.onLongPress,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppMargin.m8.r),
      color: ColorManager.secondryLight,
      child: ListTile(
        leading: leading,
        // CircleAvatar(
        //   backgroundColor: Colors.grey,
        // ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.greyDark,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        // trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
