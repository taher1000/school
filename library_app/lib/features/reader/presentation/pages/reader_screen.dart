import 'package:library_app/core/network/api_url.dart';
import 'package:library_app/core/widgets/buttons/rounded_button.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReaderScreen extends StatefulWidget {
  final String documentId;
  const ReaderScreen({super.key, required this.documentId});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final pdfViewerController = PdfViewerController();

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
        )
      ],
      body: SizedBox(
        child: SfPdfViewer.network(
          '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?documentID=${widget.documentId}',
          canShowScrollHead: false,
          controller: pdfViewerController,
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
