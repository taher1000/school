import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/color_manager.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../domain/entities/assignment_statistics.dart';

class SearchItem extends StatelessWidget {
  final String title;
  final String subTitle;

  final VoidCallback onItemSelected;
  final AssignmentStatistics assignmentStatistics;

  const SearchItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onItemSelected,
    required this.assignmentStatistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemSelected,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Assignments Details',
                  style: TextStyle(
                    color: ColorManager.darkPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildText(
                        'Total: ', assignmentStatistics.assignment.toString()),
                    _buildText('Completed: ',
                        assignmentStatistics.assignmentCompleted.toString()),
                    _buildText('Remaining: ',
                        assignmentStatistics.assignmentRemaining.toString()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String info, String infoDetails) => RichText(
        text: TextSpan(
          text: info,
          style: TextStyle(
            color: ColorManager.darkPrimary,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: infoDetails,
              style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
