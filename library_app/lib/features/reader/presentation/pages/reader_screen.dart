// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

import '../../../../core/network/api_url.dart';

//set this value to view document via Widget
var enableWidget = true;

class ReaderScreen extends StatefulWidget {
  final String bookId;
  const ReaderScreen(
      {super.key = const ValueKey('ReaderScreen'), required this.bookId});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  String _version = 'Unknown';
  late final String _document =
      '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1';
  bool _showViewer = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    if (!enableWidget) {
      showViewer();
    }

    // If you are using local files:
    // * Remove the above line `showViewer();`.
    // * Change the _document field to your local filepath.
    // * Uncomment the section below, including launchWithPermission().
    // if (Platform.isIOS) {
    // showViewer(); // Permission not required for iOS.
    // } else {
    // launchWithPermission(); // Permission required for Android.
    // }
  }

  // Uncomment this if you are using local files:
  // Future<void> launchWithPermission() async {
  //  PermissionStatus permission = await Permission.storage.request();
  //  if (permission.isGranted) {
  //    showViewer();
  //  }
  // }

  // Platform messages are asynchronous, so initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      // Initializes the PDFTron SDK, it must be called before you can use
      // any functionality.
      PdftronFlutter.initialize("your_pdftron_license_key");

      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, you want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  void showViewer() async {
    // Opening without a config file will have all functionality enabled.
    // await PdftronFlutter.openDocument(_document);

    var config = Config();
    // How to disable functionality:
    //      config.disabledElements = [Buttons.shareButton, Buttons.searchButton];
    //      config.disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
    // Other viewer configurations:
    //      config.multiTabEnabled = true;
    //      config.customHeaders = {'headerName': 'headerValue'};

    // An event listener for document loading
    var documentLoadedCancel = startDocumentLoadedListener((filePath) {});

    await PdftronFlutter.openDocument(_document, config: config);

    try {
      // The imported command is in XFDF format and tells whether to add,
      // modify or delete annotations in the current document.
      PdftronFlutter.importAnnotationCommand(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
              "    <xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">\n" +
              "      <add>\n" +
              "        <square style=\"solid\" width=\"5\" color=\"#E44234\" opacity=\"1\" creationdate=\"D:20200619203211Z\" flags=\"print\" date=\"D:20200619203211Z\" name=\"c684da06-12d2-4ccd-9361-0a1bf2e089e3\" page=\"1\" rect=\"113.312,277.056,235.43,350.173\" title=\"\" />\n" +
              "      </add>\n" +
              "      <modify />\n" +
              "      <delete />\n" +
              "      <pdf-info import-version=\"3\" version=\"2\" xmlns=\"http://www.pdftron.com/pdfinfo\" />\n" +
              "    </xfdf>");
    } on PlatformException catch (e) {}

    try {
      PdftronFlutter.importBookmarkJson('{"0":"Page 1"}');
    } on PlatformException catch (e) {}

    // An event listener for when local annotation changes are committed
    // to the document. xfdfCommand is the XFDF Command of the annotation
    // that was last changed.
    var annotCancel = startExportAnnotationCommandListener((xfdfCommand) {
      // Local annotation changed.
      // Upload XFDF command to server here.
      String command = xfdfCommand;
      // Dart limits how many characters are printed onto the console.
      // The code below ensures that all of the XFDF command is printed.
      if (command.length > 1024) {
        int start = 0;
        int end = 1023;
        while (end < command.length) {
          start += 1024;
          end += 1024;
        }
      } else {}
    });

    // An event listener for when local bookmark changes are committed to
    // the document. bookmarkJson is the JSON string containing all the
    // bookmarks that exist when the change was made.
    var bookmarkCancel = startExportBookmarkListener((bookmarkJson) {});

    var path = await PdftronFlutter.saveDocument();

    // To cancel event:
    // annotCancel();
    // bookmarkCancel();
    // documentLoadedCancel();
  }

  @override
  Widget build(BuildContext context) {
    Widget documentChild = Container();

    if (enableWidget) {
      // If using Android Widget, uncomment one of the following:
      // If using Flutter v2.3.0-17.0.pre or earlier.
      // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      // If using later Flutter versions.
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );
      documentChild = _showViewer
          ? SafeArea(
              child: DocumentView(
              onCreated: _onDocumentViewCreated,
            ))
          : Container();
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: documentChild,
      ),
    );
  }

  // This function is used to control the DocumentView widget after it
  // has been created. The widget will not work without a void
  // Function(DocumentViewController controller) being passed to it.
  void _onDocumentViewCreated(DocumentViewController controller) async {
    Config config = Config();

    var leadingNavCancel = startLeadingNavButtonPressedListener(() {
      // Uncomment this to quit viewer when leading navigation button is pressed:
      this.setState(() {
        _showViewer = !_showViewer;
      });

      // Show a dialog when leading navigation button is pressed.
      _showMyDialog();
      // Navigator.of(context).pop();
    });

    await controller.openDocument(_document, config: config);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog'),
          content: const SingleChildScrollView(
            child: Text('Leading navigation button has been pressed.'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                CustomNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// class ReaderScreen extends StatefulWidget {
//   final String bookId;
//   const ReaderScreen(
//       {super.key = const ValueKey('ReaderScreen'), required this.bookId});
//   @override
//   _ReaderScreenState createState() => _ReaderScreenState();
// }

// class _ReaderScreenState extends State<ReaderScreen> {
//   String _version = 'Unknown';
//   late final String _document =
//       '${ApiURLs.baseUrl}${ApiURLs.getReadingBookPath}?bookID=${widget.bookId}&pageNumber=1';
//   bool _showViewer = true;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();

//     showViewer();

//     // If you are using local files delete the line above, change the _document field
//     // appropriately and uncomment the section below.
//     // if (Platform.isIOS) {
//       // // Open the document for iOS, no need for permission.
//       // showViewer();
//     // } else {
//       // // Request permission for Android before opening document.
//       // launchWithPermission();
//     // }
//   }

//   // Future<void> launchWithPermission() async {
//   //  PermissionStatus permission = await Permission.storage.request();
//   //  if (permission.isGranted) {
//   //    showViewer();
//   //  }
//   // }

//   // Platform messages are asynchronous, so initialize in an async method.
//   Future<void> initPlatformState() async {
//     String version;
//     // Platform messages may fail, so use a try/catch PlatformException.
//     try {
//       // Initializes the PDFTron SDK, it must be called before you can use any functionality.
//       PdftronFlutter.initialize("your_pdftron_license_key");

//       version = await PdftronFlutter.version;
//     } on PlatformException {
//       version = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, you want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _version = version;
//     });
//   }

//   void showViewer() async {
//     // opening without a config file will have all functionality enabled.
//     // await PdftronFlutter.openDocument(_document);

//     var config = Config();
//     // How to disable functionality:
//     //      config.disabledElements = [Buttons.shareButton, Buttons.searchButton];
//     //      config.disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
//     // Other viewer configurations:
//     //      config.multiTabEnabled = true;
//     //      config.customHeaders = {'headerName': 'headerValue'};

//     // An event listener for document loading
//     var documentLoadedCancel = startDocumentLoadedListener((filePath) {
//       print("document loaded: $filePath");
//     });

//     await PdftronFlutter.openDocument(_document, config: config);

//     try {
//       // The imported command is in XFDF format and tells whether to add, modify or delete annotations in the current document.
//       PdftronFlutter.importAnnotationCommand(
//           "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
//               "    <xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">\n" +
//               "      <add>\n" +
//               "        <square style=\"solid\" width=\"5\" color=\"#E44234\" opacity=\"1\" creationdate=\"D:20200619203211Z\" flags=\"print\" date=\"D:20200619203211Z\" name=\"c684da06-12d2-4ccd-9361-0a1bf2e089e3\" page=\"1\" rect=\"113.312,277.056,235.43,350.173\" title=\"\" />\n" +
//               "      </add>\n" +
//               "      <modify />\n" +
//               "      <delete />\n" +
//               "      <pdf-info import-version=\"3\" version=\"2\" xmlns=\"http://www.pdftron.com/pdfinfo\" />\n" +
//               "    </xfdf>");
//     } on PlatformException catch (e) {
//       print("Failed to importAnnotationCommand '${e.message}'.");
//     }

//     try {
//       // Adds a bookmark into the document.
//       PdftronFlutter.importBookmarkJson('{"0":"Page 1"}');
//     } on PlatformException catch (e) {
//       print("Failed to importBookmarkJson '${e.message}'.");
//     }

//     // An event listener for when local annotation changes are committed to the document.
//     // xfdfCommand is the XFDF Command of the annotation that was last changed.
//     var annotCancel = startExportAnnotationCommandListener((xfdfCommand) {
//       String command = xfdfCommand;
//       print("flutter xfdfCommand:\n");
//       // Dart limits how many characters are printed onto the console. 
//       // The code below ensures that all of the XFDF command is printed.
//       if (command.length > 1024) {
//         int start = 0;
//         int end = 1023;
//         while (end < command.length) {
//           print(command.substring(start, end) + "\n");
//           start += 1024;
//           end += 1024;
//         }
//         print(command.substring(start));
//       } else {
//         print("flutter xfdfCommand:\n $command");
//       }
//     });

//     // An event listener for when local bookmark changes are committed to the document.
//     // bookmarkJson is JSON string containing all the bookmarks that exist when the change was made.
//     var bookmarkCancel = startExportBookmarkListener((bookmarkJson) {
//       print("flutter bookmark: $bookmarkJson");
//     });

//     var path = await PdftronFlutter.saveDocument();
//     print("flutter save: $path");

//     // To cancel event:
//     // annotCancel();
//     // bookmarkCancel();
//     // documentLoadedCancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child:
//             // Uncomment this to use Widget version of the viewer.
//             // _showViewer
//             // ? DocumentView(
//             //     onCreated: _onDocumentViewCreated,
//             //   ):
//             Container(),
//       ),
//     );
//   }

//   // This function is used to control the DocumentView widget after it has been created.
//   // The widget will not work without a void Function(DocumentViewController controller) being passed to it.
//   void _onDocumentViewCreated(DocumentViewController controller) async {
//     Config config = new Config();

//     var leadingNavCancel = startLeadingNavButtonPressedListener(() {
//       // Uncomment this to quit the viewer when leading navigation button is pressed.
//       // this.setState(() {
//       //   _showViewer = !_showViewer;
//       // });

//       // Show a dialog when leading navigation button is pressed.
//       _showMyDialog();
//     });

//     controller.openDocument(_document, config: config);
//   }

//   Future<void> _showMyDialog() async {
//     print('hello');
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // User must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('AlertDialog'),
//           content: SingleChildScrollView(
//             child: Text('Leading navigation button has been pressed.'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }