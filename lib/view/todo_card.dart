import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({required this.todoContent, Key? key}) : super(key: key);
  final String todoContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 48,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(todoContent),
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
