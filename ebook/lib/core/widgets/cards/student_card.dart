import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Widget leading;
  const StudentCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onTap,
      required this.onLongPress,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: leading,
        // CircleAvatar(
        //   backgroundColor: Colors.grey,
        // ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "المستوي الاول",
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
