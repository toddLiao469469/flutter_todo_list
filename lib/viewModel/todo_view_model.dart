import 'package:mobx/mobx.dart';
import 'package:todolist/model/todo_model.dart';

part 'todo_view_model.g.dart';

class TodoViewModel = _TodoViewModel with _$TodoViewModel;

abstract class _TodoViewModel with Store {
  @observable
  ObservableList<TodoModel> todoList =
      ObservableList.of([TodoModel(content: '123')]);

  @computed
  ObservableList<TodoModel> get completedTodos =>
      ObservableList.of(todoList.where((todo) => todo.isDone == true));

  @computed
  ObservableList<TodoModel> get pendingTodos =>
      ObservableList.of(todoList.where((todo) => todo.isDone != true));

  @action
  void removeTodo(int hashCode) {
    todoList =
        ObservableList.of(todoList.where((todo) => todo.hashCode != hashCode));
  }

  @action
  void addTodo(String input) {
    todoList = ObservableList.of([...todoList, TodoModel(content: input)]);
  }

  @action
  void toggleStatus(int hashCode) {
    todoList = ObservableList.of(todoList.map((todo) {
      if (todo.hashCode == hashCode) {
        todo.isDone = !todo.isDone;
        return todo;
      } else {
        return todo;
      }
    }));
  }
}
