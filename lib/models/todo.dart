class Todo {
  final String text;
  final String author;
  final bool completed;
  final DateTime completedAt;
  final String id;

  Todo(
      {this.author = "",
      this.id = "",
      this.completed = false,
      DateTime completedAt,
      this.text = ""})
      : completedAt = completedAt ?? DateTime.now();
}
