import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/features/reader/presentation/bloc/reader_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../data/parameters/book_content_params.dart';

class ReaderScreen extends StatefulWidget {
  final String bookId;
  final int pagesCount;
  const ReaderScreen(
      {super.key, required this.bookId, required this.pagesCount});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReaderBloc>(context).add(
      GetBookContentEvent(
        bookContentParams: BookContentParams(
            bookId: widget.bookId, pageNumber: 1, pageSize: 1000),
      ),
    );
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ReaderBloc, ReaderState>(
          builder: (context, state) {
            print("habi ${state.content.length}");
            return PageView.builder(
              onPageChanged: (value) {
                // if (value == (state.content.length - 1)) {
                //   BlocProvider.of<ReaderBloc>(context).add(
                //     GetBookContentEvent(
                //       bookContentParams: BookContentParams(
                //           bookId: widget.bookId, pageNumber: 2, pageSize: 100),
                //     ),
                //   );
                // }
              },
              itemCount: state.content.length,
              itemBuilder: (context, index) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .9,
                  ),
                  child: Wrap(
                    children: state.content[index]
                        .split(" ")
                        .map((e) => Text(
                              "$e ",
                              maxLines: 17,
                              style: TextStyle(color: ColorManager.black),
                            ))
                        .toList()
                        .animate(
                          interval: 1200.ms,
                          onComplete: (controller) {
                            controller.reverse();
                          },
                        )
                        .color(
                          duration: 400.ms,
                        ),
                  ),
                );
              },
            );
          },
        ));
  }
}
