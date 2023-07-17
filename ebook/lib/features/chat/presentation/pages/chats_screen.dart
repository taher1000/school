import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../widgets/appBar_build.dart';
import '../widgets/chat_body.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: 'Messages',
      body: const ChatScreenBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {}),
      //   backgroundColor: ColorManager.darkPrimary,
      //   child: const Icon(Icons.person_add_alt_1, color: Colors.white),
      // ),
    );
  }
}
