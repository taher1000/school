import 'package:library_app/features/student_features/my_books/presentation/pages/my_books_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/my_books_bloc.dart';

class StudentMyBooksScreen extends StatefulWidget {
  const StudentMyBooksScreen({super.key});

  @override
  State<StudentMyBooksScreen> createState() => _StudentMyBooksScreenState();
}

class _StudentMyBooksScreenState extends State<StudentMyBooksScreen> {
  @override
  void initState() {
    BlocProvider.of<MyBooksBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        canPop: false,
        screenTitle:
            AppLocalization.of(context).getTranslatedValues("my_books")!,
        body: const MyBooksBody());
  }
}
