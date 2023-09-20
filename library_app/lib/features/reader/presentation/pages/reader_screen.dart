import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:library_app/core/network/api_url.dart';
import 'package:library_app/core/widgets/buttons/rounded_button.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../domain/entities/request/book_completed_status.dart';
import '../bloc/cubit/save_student_book_status_cubit.dart';

class ReaderScreen extends StatefulWidget {
  final String bookId;
  const ReaderScreen({super.key, required this.bookId});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final pdfViewerController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  int pageNumber = 1;
  int currentPageNumber = 1;
  OverlayEntry? _overlayEntry;
  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: SizedBox(
          width: 60,
          height: 30,
          child: CustomRoundedButton(
            text: "copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: details.selectedText!));
              pdfViewerController.clearSelection();
            },
          ),
        ),
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  List<int>? _documentBytes;
  File? file;
  @override
  void initState() {
    super.initState();
    // file = File(
    //     "/Users/admin/Library/Developer/CoreSimulator/Devices/2C391867-0FDF-459D-9C8F-15613EE60D8D/data/Containers/Data/Application/A09867D0-5945-480D-9476-E2C7C1E0E330/Documents/${widget.bookId}.pdf");
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   final plc = await getApplicationDocumentsDirectory();
  //   print("plc $plc");
  //   final path = plc.path;
  //   print("path $path");
  //   file = File('$path/${widget.bookId}.pdf');
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: 'Reader',
      actions: [
        IconButton(
          icon: Icon(
            Icons.zoom_in,
            color: Colors.white,
          ),
          onPressed: () {
            pdfViewerController.zoomLevel++;
          },
        ),
        IconButton(
          icon: Icon(
            Icons.zoom_out,
            color: Colors.white,
          ),
          onPressed: () {
            pdfViewerController.zoomLevel--;
          },
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
          onPressed: () {
            pdfViewerController.previousPage();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          onPressed: () {
            pdfViewerController.nextPage();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
          onPressed: () {
            // pdfViewerController.lastPage();
            _pdfViewerKey.currentState?.openBookmarkView();
          },
        ),
      ],
      body:
          BlocListener<SaveStudentBookStatusCubit, SaveStudentBookStatusState>(
        listener: (context, state) {
          if (state is SaveStudentBookStatusSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: FutureBuilder<Directory>(
          future: getApplicationDocumentsDirectory(),
          builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final path = snapshot.data!.path;
              print("path $path");
              file = File('$path/${widget.bookId}.pdf');
              return FutureBuilder<bool>(
                future: file!.exists(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == true) {
                    return SfPdfViewer.memory(
                      file!.readAsBytesSync(),
                      key: _pdfViewerKey,
                      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                        print(details.document.pages.count);
                        // Document bytes of a PDF document loaded in SfPdfViewer.
                        // _documentBytes = details.document.saveSync();
                      },
                    );
                  } else {
                    return SfPdfViewer.network(
                      "${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1",
                      key: _pdfViewerKey,
                      canShowScrollHead: false,
                      canShowPageLoadingIndicator: false,
                      controller: pdfViewerController,
                      onDocumentLoaded: (details) async {
                        _documentBytes = details.document.saveSync();
                        if (_documentBytes != null) {
                          Directory directory =
                              await getApplicationDocumentsDirectory();
                          String path = directory.path;
                          //Create the empty file.
                          File fileWrite =
                              File('$path/${'${widget.bookId}.pdf}'}');
                          //Write the PDF data retrieved from the SfPdfViewer.
                          await fileWrite.writeAsBytes(_documentBytes!,
                              flush: true);
                          print(path);
                        }
                      },
                      onPageChanged: (details) {
                        if (details.isLastPage) {
                          BlocProvider.of<SaveStudentBookStatusCubit>(context)
                              .saveStudentBookStatus(BookCompletedStatus(
                                  bookId: widget.bookId,
                                  hasReadingCompleted: true,
                                  hasListeningCompleted: false));
                        }
                      },
                      // onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                      //   if (details.selectedText == null && _overlayEntry != null) {
                      //     _overlayEntry!.remove();
                      //     _overlayEntry = null;
                      //   } else if (details.selectedText != null &&
                      //       _overlayEntry == null) {
                      //     _showContextMenu(context, details);
                      //   }
                      // },
                      canShowScrollStatus: false,
                    );
                  }
                },
              );
            }
          },
        ),

        // FutureBuilder(
        //   future: getApplicationDocumentsDirectory(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.hasError) {
        //       return Text("Error");
        //     } else if (snapshot.hasData &&
        //         snapshot.connectionState == ConnectionState.done) {
        //       final dir = snapshot.data as Directory;
        //       // print("object ${dir.path == null}");
        //       file = File('${dir.path}/${widget.bookId}.pdf');
        //       final ex =
        //           file!.exists().then((value) => print("object ${value}"));
        //       // print("object ${file!.exists()}");
        //       return SfPdfViewer.memory(
        //         file!.readAsBytesSync(),
        //         key: _pdfViewerKey,
        //         onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        //           print(details.document.pages.count);
        //           // Document bytes of a PDF document loaded in SfPdfViewer.
        //           // _documentBytes = details.document.saveSync();
        //         },
        //       );
        //     } else {
        //       return SfPdfViewer.network(
        //         "${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1",
        //         key: _pdfViewerKey,
        //         canShowScrollHead: false,
        //         canShowPageLoadingIndicator: false,
        //         controller: pdfViewerController,
        //         onDocumentLoaded: (details) async {
        //           _documentBytes = details.document.saveSync();
        //           if (_documentBytes != null) {
        //             Directory directory =
        //                 await getApplicationDocumentsDirectory();
        //             String path = directory.path;
        //             //Create the empty file.
        //             File file = File('$path/${'${widget.bookId}.pdf}'}');
        //             //Write the PDF data retrieved from the SfPdfViewer.
        //             await file.writeAsBytes(_documentBytes!, flush: true);
        //             print(path);
        //           }
        //         },
        //         onPageChanged: (details) {
        //           if (details.isLastPage) {
        //             BlocProvider.of<SaveStudentBookStatusCubit>(context)
        //                 .saveStudentBookStatus(BookCompletedStatus(
        //                     bookId: widget.bookId,
        //                     hasReadingCompleted: true,
        //                     hasListeningCompleted: false));
        //           }
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
        //     }
        //   },
        // ),
      ),
    );
  }
}
