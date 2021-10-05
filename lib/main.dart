import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todolist/view/todo_card.dart';
import 'package:todolist/view/todo_list_section.dart';

import 'model/todo_filter_model.dart';
import 'model/todo_model.dart';
import 'viewModel/todo_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TodoFliterModel _todoFilter = TodoFliterModel();
  final TodoViewModel todoViewModel = TodoViewModel();
  void _handleAddNewTodo(String input) {
    todoViewModel.addTodo(input);
    _textEditingController.text = '';
  }

  void _handleRemoveTodo(int hashCode) {
    todoViewModel.removeTodo(hashCode);
  }

  void _handleToggleStatus(int hashCode) {
    todoViewModel.toggleStatus(hashCode);
  }

  void _handleFilteTodoStatue() {
    setState(() {
      _todoFilter.isDone = !_todoFilter.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(labelText: '待辦事項'),
                  onSubmitted: (input) {
                    _handleAddNewTodo(input);
                  },
                  controller: _textEditingController,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Observer(builder: (_) {
                return Text(
                  '目前' + (_todoFilter.isDone ? '已完成' : '未完成') + '的Todo：',
                  style: Theme.of(context).textTheme.headline5,
                );
              }),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 36,
                    child: const Text('切換完成狀態'),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                onTap: () {
                  _handleFilteTodoStatue();
                },
              ),
              TodoListSection(
                todoViewModel: todoViewModel,
                todoFilter: _todoFilter,
                handleRemoveTodo: _handleRemoveTodo,
                handleToggleStatus: _handleToggleStatus,
              )
            ],
          ),
        ),
      ),
    );
  }
}
