import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_body.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      screenTitle: 'Messages',
      body: ChatScreenBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {}),
      //   backgroundColor: ColorManager.darkPrimary,
      //   child: const Icon(Icons.person_add_alt_1, color: Colors.white),
      // ),
    );
  }
}
