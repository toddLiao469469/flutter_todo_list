import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({required this.todoContent, required this.index, Key? key})
      : super(key: key);
  final String todoContent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints(minHeight: 48),
        width: 300,
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Text('#$index： $todoContent'),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
