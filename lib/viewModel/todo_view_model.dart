import 'package:mobx/mobx.dart';
import 'package:todolist/model/todo_model.dart';

// Include generated file
part 'todo_view_model.g.dart';

// This is the class used by rest of your codebase
class TodoViewModel = _TodoViewModel with _$TodoViewModel;

abstract class _TodoViewModel with Store {
  @observable
  List<TodoModel> todoList = [TodoModel(content: '123')];

  @action
  void removeTodo(int hashCode) {
    todoList = todoList.where((todo) => todo.hashCode != hashCode).toList();
  }

  @action
  void addTodo(String input) {
    todoList = [...todoList, TodoModel(content: input)];
  }

  @action
  void toggleStatus(int hashCode) {
    todoList = todoList.map((todo) {
      if (todo.hashCode == hashCode) {
        todo.isDone = !todo.isDone;
        return todo;
      } else {
        return todo;
      }
    }).toList();
  }
}
