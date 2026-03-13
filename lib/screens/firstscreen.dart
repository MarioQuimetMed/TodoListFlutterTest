
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../helpers/database_helper.dart';
import '../models/task.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  final dbHelper = DatabaseHelper();
  List<Task> _tasks = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await dbHelper.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask(String title) async {
    final newTask = Task(title: title);
    await dbHelper.insertTask(newTask);
    _loadTasks();
  }

  Future<void> _updateTaskCompletion(Task task, bool isCompleted) async {
    task.isCompleted = isCompleted;
    await dbHelper.updateTask(task);
    _loadTasks();
  }

  Future<void> _deleteTask(String title) async {
    await dbHelper.deleteTask(title);
    _loadTasks();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C2C2C),
          title: const Text('New Mission', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _textFieldController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "What's your next goal?",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF8E24AA)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBC02D)),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                Navigator.of(context).pop();
                _textFieldController.clear();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E24AA),
              ),
              child: const Text('ADD MISSION', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  _addTask(_textFieldController.text);
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

  Widget _buildTaskList() {
    if (_tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Ready for a new mission?",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
            const Text(
              "Add your first task to get started!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ).animate().fade(duration: 500.ms).slideY(begin: 0.2),
      );
    }
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Animate(
          effects: [FadeEffect(duration: 300.ms, delay: (index * 100).ms), SlideEffect(begin: const Offset(-0.1, 0))],
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: GestureDetector(
                onTap: () => _updateTaskCompletion(task, !task.isCompleted),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: task.isCompleted ? const Color(0xFFFBC02D) : Colors.grey, width: 2),
                    color: task.isCompleted ? const Color(0xFFFBC02D) : Colors.transparent,
                  ),
                  child: task.isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.black)
                      : null,
                ),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 16,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
                onPressed: () => _deleteTask(task.title),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Awesome Tasks'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
