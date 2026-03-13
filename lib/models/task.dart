
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // Método para convertir un objeto Task a un Map, útil para la BD
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
