import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../data/models/data.dart';

class ReadNovel extends StatelessWidget {
  var information36 =
      const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Roboto');
  final DataNovel data;
  ReadNovel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: 'Chapter 1',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Center(
                          child: Text(data.chapter,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                  ))),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data.content,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorManager.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
