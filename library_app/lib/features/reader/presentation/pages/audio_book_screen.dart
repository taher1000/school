import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:library_app/features/reader/presentation/bloc/reader_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../data/parameters/book_content_params.dart';

class AudioBookScreen extends StatefulWidget {
  final String bookId;

  const AudioBookScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<AudioBookScreen> createState() => _AudioBookScreenState();
}

class _AudioBookScreenState extends State<AudioBookScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    ftts = FlutterTts();
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

  late final FlutterTts ftts;
  @override
  void didChangeDependencies() async {
    await init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ftts.stop();
    super.dispose();
  }

  String currentWord = "";
  int startOffset = 0;
  int endOffset = 0;
  bool findFirstWord = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
          ),
        ),
        body: BlocBuilder<ReaderBloc, ReaderState>(
          builder: (context, state) {
            return PageView.builder(
              onPageChanged: (value) async {
                ftts.stop();

                setState(() {
                  startOffset = 0;
                  endOffset = 0;
                  currentWord = "";
                });
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: ColorManager.darkPrimary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  ftts.pause();
                                },
                                icon: const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  ftts.speak(state.content[index]);
                                  ftts.setProgressHandler(
                                      (text, start, end, word) {
                                    setState(() {
                                      currentWord = word;
                                      startOffset = start;
                                      endOffset = end;
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: startOffset != 0
                                  ? state.content[index]
                                      .substring(1, startOffset)
                                  : "",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                          TextSpan(
                              text: state.content[index]
                                  .substring(startOffset, endOffset),
                              style: TextStyle(
                                  backgroundColor: ColorManager.darkPrimary,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          TextSpan(
                              text: state.content[index].substring(endOffset),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        ]),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }

  Future init() async {
    await ftts.setSharedInstance(true);
    ftts.setLanguage(
        const Locale.fromSubtags(languageCode: 'ar', countryCode: 'SA')
            .languageCode);

    await ftts.setSpeechRate(.5); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1); //pitc of sound
  }
}
