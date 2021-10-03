import 'package:flutter/material.dart';
import 'package:todolist/view/todo_card.dart';
import 'package:todolist/view/todo_list_section.dart';

import 'model/todo_filter_model.dart';
import 'model/todo_model.dart';

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
  List<TodoModel> _todoList = [TodoModel(content: '123')];
  final TextEditingController _textEditingController = TextEditingController();
  final TodoFliterModel _todoFilter = TodoFliterModel();
  void _handleAddNewTodo(String input) {
    setState(() {
      _todoList = [..._todoList, TodoModel(content: input)];
      _textEditingController.text = '';
    });
  }

  void _handleRemoveTodo(int hashCode) {
    setState(() {
      _todoList =
          _todoList.where((value) => value.hashCode != hashCode).toList();
    });
  }

  void _handleToggleStatus(int hashCode) {
    setState(() {
      _todoList = _todoList.map((value) {
        if (value.hashCode == hashCode) {
          value.toggleStatus();
          return value;
        } else {
          return value;
        }
      }).toList();
    });
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
                  decoration: const InputDecoration(labelText: '待辦事項'),
                  onSubmitted: (input) {
                    _handleAddNewTodo(input);
                  },
                  controller: _textEditingController,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                '目前的Todo:',
                style: Theme.of(context).textTheme.headline5,
              ),
              GestureDetector(
                child: SizedBox(
                  width: 60,
                  height: 24,
                  child: Text(_todoFilter.isDone ? '完成' : '未完成'),
                ),
                onTap: () {
                  _handleFilteTodoStatue();
                },
              ),
              TodoListSection(
                todoList: _todoList,
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
