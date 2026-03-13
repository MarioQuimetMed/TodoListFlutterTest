import 'package:flutter/material.dart';

// 1. Modelo para representar una tarea
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  // 2. Lista para almacenar las tareas
  final List<Task> _tasks = [];
  final TextEditingController _textFieldController = TextEditingController();

  // 3. Método para mostrar el diálogo y agregar una nueva tarea
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Enter task name"),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
                _textFieldController.clear();
              },
            ),
            ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  // Llama a setState para actualizar la UI con la nueva tarea
                  setState(() {
                    _tasks.add(Task(title: _textFieldController.text));
                  });
                  _textFieldController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 4. Método para construir la lista de tareas
  Widget _buildTaskList() {
    // Mensaje si no hay tareas
    if (_tasks.isEmpty) {
      return const Center(
        child: Text(
          "No tasks yet! ✨",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    // ListView para las tareas existentes
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 3,
          child: ListTile(
            // Checkbox para marcar como completada
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  task.isCompleted = value!;
                });
              },
            ),
            // Título de la tarea (tachado si está completada)
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.isCompleted ? Colors.grey : null,
              ),
            ),
            // Botón para eliminar la tarea
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Task List')),
      // Construye el cuerpo de la app
      body: _buildTaskList(),
      // Botón para agregar nuevas tareas
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
