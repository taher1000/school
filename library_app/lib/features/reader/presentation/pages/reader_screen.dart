import 'dart:async';

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

  File? file;
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
                PdfDocument document = PdfDocument(
                    inputBytes: File(
                            "/Users/admin/Library/Developer/CoreSimulator/Devices/2C391867-0FDF-459D-9C8F-15613EE60D8D/data/Containers/Data/Application/57C9AD95-451B-4D3C-9F59-03A8FB2D3F51/Library/Caches/libCachedPdfView/4b30fb90-626e-11ee-a5ed-e147db06368b.pdf")
                        .readAsBytesSync());
                print("file is ${document}");
//Creates a document bookmark
                PdfBookmark bookmark = document.bookmarks.add('Page 1');

//Sets the destination page and location
                bookmark.destination =
                    PdfDestination(document.pages[0], Offset(20, 20));

//Sets the bookmark color
                bookmark.color = PdfColor(255, 0, 0);

//Sets the text style
                bookmark.textStyle = [PdfTextStyle.bold];

//Saves the document
                File("/Users/admin/Library/Developer/CoreSimulator/Devices/2C391867-0FDF-459D-9C8F-15613EE60D8D/data/Containers/Data/Application/57C9AD95-451B-4D3C-9F59-03A8FB2D3F51/Library/Caches/libCachedPdfView/4b30fb90-626e-11ee-a5ed-e147db06368b.pdf")
                    .writeAsBytes(await document.save());

//Disposes the document
                document.dispose();
              }),
        ],
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocListener<SaveStudentBookStatusCubit,
                    SaveStudentBookStatusState>(
                listener: (context, state) {
                  if (state is SaveStudentBookStatusSuccess) {
                    showSnackBar(
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
                        ).fromAsset(
                          "/Users/admin/Library/Developer/CoreSimulator/Devices/2C391867-0FDF-459D-9C8F-15613EE60D8D/data/Containers/Data/Application/57C9AD95-451B-4D3C-9F59-03A8FB2D3F51/Library/Caches/libCachedPdfView/4b30fb90-626e-11ee-a5ed-e147db06368b.pdf",
                          // '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1',
                          // maxNrOfCacheObjects: 10,
                          // whenDone: (filePath) {
                          //   if (file == null) {
                          //     file = File(filePath);
                          //     print("file is downloaded to $filePath");
                          //   }
                          // },
                          // headers: {
                          //   'Authorization':
                          //       'Bearer ${sharedPrefsClient.accessToken}'
                          // },
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
