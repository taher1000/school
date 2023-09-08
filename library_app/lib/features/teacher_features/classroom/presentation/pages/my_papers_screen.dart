import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/widgets/buttons/dotted_button.dart';
import '../../../../../core/widgets/text/custom_text.dart';
import '../../../../../injection_container.dart';

class MyPapersScreen extends StatefulWidget {
  const MyPapersScreen({Key? key}) : super(key: key);

  @override
  _MyPapersScreenState createState() => _MyPapersScreenState();
}

class _MyPapersScreenState extends State<MyPapersScreen>
    with SingleTickerProviderStateMixin {
  File file = File("");
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "أوراقي",
      body: Column(
        children: <Widget>[
          SvgPicture.asset(
            SvgAssets.empty,
            height: 300,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: DottedButton(
              onTap: () async {
                final result = await pickFile();

                if (result != null) {
                  file = File(result.files.first.path.toString());
                  files.add(file);
                  setState(() {});
                }
              },
              icon: FontAwesomeIcons.folderOpen,
              text: 'Select your file',
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2.5),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: files.length,
              itemBuilder: (context, index) => FileBadgeWidget(
                    filename: files[index].path.split('/').last,
                    onDeleted: () async {
                      setState(() {
                        files.removeAt(index);
                      });
                    },
                  )),
        ],
      ),
    );
  }

  Future<FilePickerResult?> pickFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        'doc',
        'docx',
        'pdf',
        'PNG',
        'JPG',
        'JPEG',
        'DOC',
        'DOCX',
        'PDF'
      ],
    );
  }

  Future<void> pickAttachment(String? subject, int attachmentIndex,
      {bool hasMaxSize = false}) async {
    final result = await pickFile();

    if (result != null) {
      file = File(result.files.first.path.toString());
    }
  }
}

class FileBadgeWidget extends StatelessWidget {
  final void Function() onDeleted;
  final String filename;
  const FileBadgeWidget(
      {super.key, required this.onDeleted, required this.filename});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 10, top: 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Chip(
            label: SizedBox(
              height: 30,
              child: CustomText(
                filename,
                style: TextStyleManager.getRegularStyle(
                    color: Colors.black, fontSize: FontSize.s14),
                textDirection:
                    sharedPrefsClient.currentLanguage.toLowerCase() == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
              ),
            ),
            deleteIcon: InkWell(
              onTap: onDeleted,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            onDeleted: onDeleted,
            backgroundColor: Colors.grey[300],
          ),
        ));
  }
}
