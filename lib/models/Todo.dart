class Todo {
  late int id;
  late String text;
  late bool isCompleted;

  Todo({required this.id, required this.text, this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
