import 'dart:async';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/features/reader/presentation/widgets/count_down_widget.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import 'dart:io';

import '../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../domain/entities/request/book_completed_status.dart';
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
  void dispose() {
    super.dispose();
  }

  File file = File(
      "/var/mobile/Containers/Data/Application/8D92D4E6-37D3-4700-8E6C-57C089AB35FA/Library/Caches/libCachedPdfView/734826f0-6361-11ee-9aa8-33cfa0c0a121.pdf");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: "",
        canPop: false,
        actions: [
          Center(
              child: CustomCountDownWidget(
            minutes: widget.pagesCount * 2,
            bookId: widget.bookId,
          )),
          IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () async {
                PdfDocument document =
                    PdfDocument(inputBytes: file.readAsBytesSync());

                //Adds a page
                document.bookmarks.insert(0, "title");
                // PdfPage page = document.pages.add();
                //Creates a bookmark
                PdfBookmark bookmark = document.bookmarks.add('Chapter 3');
                // //Sets the destination page and locaiton
                bookmark.destination =
                    PdfDestination(document.pages[0], Offset(50, 50));
                // //Draw the content in the PDF page
                document.pages[0].graphics.drawString(
                    'Chapter1', PdfStandardFont(PdfFontFamily.helvetica, 10),
                    brush: PdfBrushes.red, bounds: Rect.fromLTWH(50, 50, 0, 0));
                // //Adds the child bookmark
                PdfBookmark childBookmark = bookmark.insert(0, 'Section 1');
                childBookmark.destination =
                    PdfDestination(document.pages[0], Offset(30, 30));
                // //Draw the content in the PDF page
                document.pages[0].graphics.drawString(
                    'Section1', PdfStandardFont(PdfFontFamily.helvetica, 10),
                    brush: PdfBrushes.green,
                    bounds: Rect.fromLTWH(30, 30, 0, 0));
                // //Sets the text style and color
                bookmark.textStyle = [PdfTextStyle.bold];
                bookmark.color = PdfColor(255, 0, 0);
                // //Save the document
                await document.save();
                // //Dispose the document.
                // document.dispose();

                //Save the file and launch/download.
              }),
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
                child: FutureBuilder<int?>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return PDF(
                          onPageChanged: (page, total) {
                            sharedPrefsClient.prefs
                                .setInt("Page Key: ${widget.bookId}", page!);
                            if (page == (total! - 1)) {
                              BlocProvider.of<SaveStudentBookStatusCubit>(
                                      context)
                                  .saveStudentBookStatus(BookCompletedStatus(
                                      bookId: widget.bookId,
                                      hasReadingCompleted: true,
                                      hasListeningCompleted: false));
                            }
                          },
                          defaultPage: snapshot.data ?? 0,
                        ).cachedFromUrl(
                          // .fromAsset(
                          // file.path,
                          '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1',
                          maxNrOfCacheObjects: 10,
                          whenDone: (filePath) {
                            if (file == null) {
                              file = File(filePath);
                              print("file is downloaded to ${file!.path}");
                            }
                          },
                          headers: {
                            'Authorization':
                                'Bearer ${sharedPrefsClient.accessToken}'
                          },
                        );
                      }
                    })),
          ],
        ));
  }

  Future<int?> getData() async {
    final data =
        await sharedPrefsClient.prefs.getInt("Page Key: ${widget.bookId}");
    return data;
  }
}
