import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants.dart';
import '../../../../core/resources/color_manager.dart';
import '../bloc/books_bloc.dart';

class BookLevelList extends StatefulWidget {
  final Function(int?)? onLevelSelected;
  const BookLevelList({super.key, this.onLevelSelected});

  @override
  State<BookLevelList> createState() => _BookLevelListState();
}

class _BookLevelListState extends State<BookLevelList> {
  int selectedLevel = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: AppConstants.bookLevelImages.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            if (selectedLevel ==
                    AppConstants.bookLevelImages.values.toList()[i] &&
                selectedLevel != 0) {
              widget.onLevelSelected!(0);
              // BlocProvider.of<BooksBloc>(context).add(FetchBooks());
              setState(() {
                selectedLevel = 0;
              });
            } else {
              widget.onLevelSelected!(
                  AppConstants.bookLevelImages.values.toList()[i]);

              // BlocProvider.of<BooksBloc>(context).add(FetchBooks(
              //     bookLevel: AppConstants.bookLevelImages.values.toList()[i]));
              setState(() {
                selectedLevel = AppConstants.bookLevelImages.values.toList()[i];
              });
            }
          },
          child: Card(
            shadowColor: ColorManager.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            color:
                selectedLevel == AppConstants.bookLevelImages.values.toList()[i]
                    ? ColorManager.darkPrimary
                    : ColorManager.white,
            elevation:
                selectedLevel == AppConstants.bookLevelImages.values.toList()[i]
                    ? 15.h
                    : 0,
            child: Image.asset(AppConstants.bookLevelImages.keys.toList()[i],
                fit: BoxFit.contain, width: 40.w, height: 50.h),
          ),
        );
      },
    );
  }
}
