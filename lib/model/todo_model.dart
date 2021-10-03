class TodoModel {
  final String content;
  bool isDone;

  TodoModel({required this.content, this.isDone = false});
  void toggleStatus() {
    isDone = !isDone;
  }
}
