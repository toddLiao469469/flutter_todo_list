import 'package:flutter/material.dart';
import 'package:todolist/view/todo_card.dart';

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

  void _handleAddNewTodo(String input) {
    setState(() {
      _todoList = [..._todoList, TodoModel(content: input)];
      _textEditingController.text = '';
    });
  }

  void _handleRemoveTodo(int hashCode) {
    setState(() {
      _todoList =
          _todoList.takeWhile((value) => value.hashCode != hashCode).toList();
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
              ..._todoList.asMap().entries.map(
                    (entity) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TodoCard(
                          todoContent: entity.value.content,
                          index: entity.key,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.remove),
                          onTap: () {
                            _handleRemoveTodo(entity.value.hashCode);
                          },
                        )
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
