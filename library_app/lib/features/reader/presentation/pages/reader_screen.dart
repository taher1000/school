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

class ReaderScreen extends StatefulWidget {
  final String documentId;
  const ReaderScreen({super.key, required this.documentId});

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
            _pdfViewerKey.currentState?.openBookmarkView();
          },
        ),
      ],
      body: SizedBox(
        child:
            //  PDF(
            //   swipeHorizontal: true,
            //   onPageChanged: (page, total) {
            //     print('page change: $page/$total');
            //      if (pdfViewerController.pageNumber == 2) {
            //       pageNumber = pageNumber - 5;
            //     }
            //   },
            // ).cachedFromUrl(
            //     'http://172.16.100.106/API/v1/Book/DownloadFile?bookID=zTJaMu9yMn4%3D&pageNumber=$pageNumber'),

            SfPdfViewer.network(
          "http://172.16.100.106/API/v1/Book/DownloadFile?bookID=zTJaMu9yMn4%3D&pageNumber=$pageNumber",
          key: _pdfViewerKey,

          // '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?documentID=${widget.documentId}',
          canShowScrollHead: false, canShowPageLoadingIndicator: false,
          controller: pdfViewerController,
          onPageChanged: (details) {
            // currentPageNumber = ;
            if (pdfViewerController.pageNumber == 3) {
              // setState(() {
              pageNumber = pageNumber + 5;
              // });
            }
            if (pdfViewerController.pageNumber == 2) {
              pageNumber = pageNumber - 5;
            }
            // print();
            setState(() {});
          },
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);
            }
          },
          canShowScrollStatus: false,
        ),
      ),
    );
  }
}
