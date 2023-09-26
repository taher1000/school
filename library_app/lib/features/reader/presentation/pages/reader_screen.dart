import 'package:confetti/confetti.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../injection_container.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../domain/entities/request/book_completed_status.dart';
import '../bloc/cubit/save_student_book_status_cubit.dart';

class ReaderScreen extends StatefulWidget {
  final String bookId;
  const ReaderScreen({super.key, required this.bookId});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late ConfettiController _controllerTopCenter;

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  int score = 20;

  final pdfViewerController = PdfViewerController();
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  // int pageNumber = 1;
  // int currentPageNumber = 1;
  // PdfDocument? document;
  // OverlayEntry? _overlayEntry;
  // void _showContextMenu(
  //     BuildContext context, PdfTextSelectionChangedDetails details) {
  //   final OverlayState _overlayState = Overlay.of(context);
  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: details.globalSelectedRegion!.center.dy - 55,
  //       left: details.globalSelectedRegion!.bottomLeft.dx,
  //       child: SizedBox(
  //         width: 60,
  //         height: 30,
  //         child: CustomRoundedButton(
  //           text: "copy",
  //           onPressed: () {
  //             Clipboard.setData(ClipboardData(text: details.selectedText!));
  //             pdfViewerController.clearSelection();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  //   _overlayState.insert(_overlayEntry!);
  // }

  // late PdfViewerController _pdfViewerController;

  // List<int>? _documentBytes;
  File? file;
  @override
  void initState() {
    super.initState();
    _controllerTopCenter = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    // _pdfViewerController = PdfViewerController();

    // file = File(
    //     "/Users/admin/Library/Developer/CoreSimulator/Devices/2C391867-0FDF-459D-9C8F-15613EE60D8D/data/Containers/Data/Application/A09867D0-5945-480D-9476-E2C7C1E0E330/Documents/${widget.bookId}.pdf");
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   final plc = await getApplicationDocumentsDirectory();
  //   final path = plc.path;
  //   file = File('$path/${widget.bookId}.pdf');
  //   print("path $file");
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: 'Reader',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.zoom_in,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.zoomLevel++;
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.zoom_out,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.zoomLevel--;
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.previousPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              pdfViewerController.nextPage();
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () async {
                // if (_documentBytes != null) {
                // Directory directory = await getApplicationDocumentsDirectory();
                // String path = directory.path;
                //Create the empty file.
                // File file = File('$path/${widget.bookId}.pdf');
                //Write the PDF data retrieved from the SfPdfViewer.
                // await file!.writeAsBytes(file., flush: true);
                // print(path);
                // print(file);
              }
              // _pdfViewerKey.currentState?.openBookmarkView();
              // },
              ),
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
                child:
                    // FutureBuilder<Directory>(
                    //   future: getApplicationDocumentsDirectory(),
                    //   builder:
                    //       (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     } else if (snapshot.hasData) {
                    //       final path = snapshot.data!.path;
                    //       file = File('$path/${widget.bookId}.pdf');
                    //       if (!file!.existsSync()) {
                    // return
                    PDF(
                  onPageChanged: (page, total) {
                    if (page == (total! - 1)) {
                      _controllerTopCenter.play();
                      BlocProvider.of<SaveStudentBookStatusCubit>(context)
                          .saveStudentBookStatus(BookCompletedStatus(
                              bookId: widget.bookId,
                              hasReadingCompleted: true,
                              hasListeningCompleted: false));
                    }
                  },
                ).cachedFromUrl(
                  '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1',
                  maxNrOfCacheObjects: 10,

                  headers: {
                    'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
                  },
                  // file!.path,
                )
                //       }
                //       return PDF(
                //         swipeHorizontal: true,
                //       ).fromAsset(
                //         file!.path,
                //         // '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1'
                //       );
                //     } else {
                //       return Center(
                //         child: Text("No data"),
                //       );
                //     }
                //   },
                // )

                //     FutureBuilder<Directory>(
                //   future: getApplicationDocumentsDirectory(),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return Center(child: CircularProgressIndicator());
                //     } else if (snapshot.hasData) {
                //       final path = snapshot.data!.path;
                //       file = File('$path/${widget.bookId}.pdf');
                //       if (!file!.existsSync())
                //         return SfPdfViewer.network(
                //           "${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1",
                //           key: _pdfViewerKey,
                //           onDocumentLoaded: (details) async {
                //             _documentBytes = details.document.saveSync();
                //           },
                //         );
                //       return SfPdfViewer.asset(
                //         file!.path,
                //         // "${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1",
                //         key: _pdfViewerKey,
                //         canShowScrollHead: false,
                //         canShowPageLoadingIndicator: false,
                //         controller: pdfViewerController,

                //         onDocumentLoaded: (details) async {
                //           _documentBytes = details.document.saveSync();
                //         },
                //         onPageChanged: (details) {
                // if (details.isLastPage) {
                //   BlocProvider.of<SaveStudentBookStatusCubit>(context)
                //       .saveStudentBookStatus(BookCompletedStatus(
                //           bookId: widget.bookId,
                //           hasReadingCompleted: true,
                //           hasListeningCompleted: false));
                // }
                //         },
                //         // onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                //         //   if (details.selectedText == null && _overlayEntry != null) {
                //         //     _overlayEntry!.remove();
                //         //     _overlayEntry = null;
                //         //   } else if (details.selectedText != null &&
                //         //       _overlayEntry == null) {
                //         //     _showContextMenu(context, details);
                //         //   }
                //         // },
                //         canShowScrollStatus: false,
                //       );
                //     } else {
                //       return Center(
                //         child: Text("No data"),
                //       );
                //     }
                //   },
                // )
                ),
            ConfettiWidget(
              numberOfParticles: 50,
              blastDirectionality: BlastDirectionality.explosive,
              confettiController: _controllerTopCenter,
            )
          ],
        ));
  }
}
