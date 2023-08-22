import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/books_bloc.dart';
import '../widgets/books_grid_widget.dart';

class BooksScreen extends StatefulWidget {
  final bool canPop;
  const BooksScreen({
    super.key,
    this.canPop = false,
  });

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تصفح المحتوي",
      canPop: widget.canPop,
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.bookLevelImages.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<BooksBloc>(context).add(FetchBooks(
                        bookLevel:
                            AppConstants.bookLevelImages.values.toList()[i]));
                  },
                  child: Image.asset(
                      AppConstants.bookLevelImages.keys.toList()[i],
                      width: 30,
                      height: 30),
                );
              },
            ),
          ),
          const BooksItemsGridWidget()
        ],
      ),
    );
  }
}
