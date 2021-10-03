import 'package:flutter/material.dart';
import 'package:todolist/model/todo_filter_model.dart';
import 'package:todolist/model/todo_model.dart';

import 'todo_card.dart';

typedef HandleToggleStatus = void Function(int hashcode);
typedef HandleRemoveTodo = void Function(int hashcode);

class TodoListSection extends StatelessWidget {
  const TodoListSection({
    required this.todoList,
    required this.todoFilter,
    required this.handleToggleStatus,
    required this.handleRemoveTodo,
    Key? key,
  }) : super(key: key);
  final List<TodoModel> todoList;
  final TodoFliterModel todoFilter;
  final HandleToggleStatus handleToggleStatus;
  final HandleRemoveTodo handleRemoveTodo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...todoList
            .where(
              (element) => element.isDone == todoFilter.isDone,
            )
            .toList()
            .asMap()
            .entries
            .map(
              (entity) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: TodoCard(
                        todoContent: entity.value.content,
                        index: entity.key,
                        isDone: entity.value.isDone),
                    onTap: () {
                      handleToggleStatus(entity.value.hashCode);
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.remove),
                    onTap: () {
                      handleRemoveTodo(entity.value.hashCode);
                    },
                  )
                ],
              ),
            ),
      ],
    );
  }
}
