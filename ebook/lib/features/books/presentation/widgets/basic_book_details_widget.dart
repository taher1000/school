import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/entities/book.dart';
import 'book_info.dart';

class BasicBookDetailsWidget extends StatefulWidget {
  final Book book;
  const BasicBookDetailsWidget({super.key, required this.book});

  @override
  State<BasicBookDetailsWidget> createState() => _BasicBookDetailsWidgetState();
}

class _BasicBookDetailsWidgetState extends State<BasicBookDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final List optionList = ["Reading", "Listening", "Quiz"];
    bool isReadingChecked = false;
    bool isListeningChecked = false;
    bool isQuizChecked = false;
    late List<bool> selectedOptions = [
      isReadingChecked,
      isListeningChecked,
      isQuizChecked
    ];
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.1,
      child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(ImageAssets.book1),
                          // child: Image.memory(
                          //   base64Decode(book.image!),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BookInfo(book: widget.book),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: optionList.length,
                              itemBuilder: (_, int index) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: CheckboxListTile(
                                    title: Text(optionList[index]),
                                    value: selectedOptions[index],
                                    onChanged: (val) {
                                      setState(() {
                                        selectedOptions[index] = val!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
