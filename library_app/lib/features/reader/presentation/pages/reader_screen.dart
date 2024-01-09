import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:library_app/features/reader/presentation/widgets/count_down_widget.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
  String filePath = "";
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: "",
        canPop: false,
        actions: [
          IconButton(
              onPressed: () async {
                //Create a new PDF document
                PdfDocument document = PdfDocument(
                    inputBytes: File(
                            "/data/user/0/com.example.library_app/cache/libCachedPdfView/19600f20-43a3-1e45-a587-b9c7b6bc71e6.pdf")
                        .readAsBytesSync());

//Draw the rectangle on PDF document
                document.pages[0].graphics.drawRectangle(
                    brush: PdfBrushes.chocolate,
                    bounds: Rect.fromLTWH(10, 10, 100, 50));

//Save the PDF document
                File("/data/user/0/com.example.library_app/cache/libCachedPdfView/19600f20-43a3-1e45-a587-b9c7b6bc71e6.pdf")
                    .writeAsBytes(await document.save());

//Dispose the document
                document.dispose();
              },
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: Colors.white,
              ))
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
                child:
                    // SfPdfViewer.file(File(
                    //     "/data/user/0/com.example.library_app/cache/libCachedPdfView/19600f20-43a3-1e45-a587-b9c7b6bc71e6.pdf"))
                    PDF(
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
                  whenDone: (filePath) {
                    print(filePath);
                    //data/user/0/com.example.library_app/cache/libCachedPdfView/b91e2700-eeac-1e44-9101-19a5ac5e0dcb.pdf
                  },
                  headers: {
                    'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
                  },
                ))
          ],
        ));
  }

  int? getData() {
    final data = sharedPrefsClient.prefs.getInt("Page Key: ${widget.bookId}");
    return data;
  }
}
