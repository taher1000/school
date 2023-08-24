import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:ebook/features/student_features/my_books/presentation/bloc/my_books_bloc.dart';
import 'package:ebook/features/student_features/my_books/presentation/widgets/my_books_grid_widget.dart';
import 'package:ebook/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/widgets/books_grid_widget.dart';

class StudentMyBooksScreen extends StatelessWidget {
  final bool canPop;
  const StudentMyBooksScreen({
    super.key,
    this.canPop = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: AppLocalization.of(context).getTranslatedValues("my_books")!,
      canPop: canPop,
      body: BlocProvider<MyBooksBloc>(
        create: (context) => MyBooksBloc(getIt()),
        child: Column(
          children: [
            SizedBox(height: 40.h, child: const BookLevelList()),
            const StudentMyBooksItemsGridWidget()
          ],
        ),
      ),
    );
  }
}
