import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:library_app/features/reader/presentation/widgets/count_down_widget.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/popup/custom_snack_bar.dart';
import '../bloc/cubit/save_student_book_status_cubit.dart';

class ReaderScreen extends StatefulWidget {
  final String bookId;
  final int pagesCount;
  const ReaderScreen(
      {super.key, required this.bookId, required this.pagesCount});
  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: "",
        canPop: false,
        actions: [
          // Center(
          //     child: CustomCountDownWidget(
          //   minutes: widget.pagesCount * 2,
          //   bookId: widget.bookId,
          // )),
        ],
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocListener<SaveStudentBookStatusCubit,
                    SaveStudentBookStatusState>(
                listener: (context, state) {
                  if (state is SaveStudentBookStatusSuccess) {
                    showCustomSnackBar(
                      context,
                      message: "congrats_read_full_book",
                    );
                  }
                },
                child: PDF(
                  onPageChanged: (page, total) {
                    // sharedPrefsClient.prefs
                    //     .setInt("Page Key: ${widget.bookId}", page!);
                    // if (page == (total! - 1)) {
                    //   BlocProvider.of<SaveStudentBookStatusCubit>(context)
                    //       .saveStudentBookStatus(BookCompletedStatus(
                    //           bookId: widget.bookId,
                    //           hasReadingCompleted: true,
                    //           hasListeningCompleted: false));
                    // }
                  },
                ).cachedFromUrl(
                  '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1',
                  maxNrOfCacheObjects: 10,
                  whenDone: (filePath) {},
                  headers: {
                    'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
                  },
                ))
          ],
        ));
  }

  Future<int?> getData() async {
    final data =
        await sharedPrefsClient.prefs.getInt("Page Key: ${widget.bookId}");
    return data;
  }
}
