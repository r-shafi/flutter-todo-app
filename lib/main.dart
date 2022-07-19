import 'package:flutter/material.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/widgets/todo_item.dart';

void main() => runApp(const Todo());

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo Application',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoModel> _todoList = [];
  final TextEditingController _textFieldController = TextEditingController();

  _addTodo(String title, BuildContext bottomSheetContext) {
    if (title.isEmpty) {
      Navigator.of(bottomSheetContext).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Can\'t Set Empty ToDo!'),
        ),
      );
      return;
    }

    setState(() {
      _todoList.add(
        TodoModel(
          _todoList.length,
          title,
          false,
          DateTime.now(),
        ),
      );
      _textFieldController.clear();
    });
    Navigator.of(bottomSheetContext).pop();
  }

  void _updateTodo(TodoModel todo) {
    int index = _todoList.indexWhere((element) => element.id == todo.id);

    setState(() {
      _todoList[index] =
          TodoModel(todo.id, todo.title, !todo.isDone, todo.date);
    });
  }

  _openBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    label: Text('Add Title'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _addTodo(_textFieldController.text, context);
                      },
                      child: const Text('Add Todo'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Application'),
        actions: [
          IconButton(
            onPressed: () => _openBottomSheet(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _todoList.isNotEmpty
          ? ListView(
              children:
                  _todoList.map((todo) => TodoItem(todo, _updateTodo)).toList(),
            )
          : const Center(
              child: Text(
                'Add Todo\'s to See Them Here!',
                style: TextStyle(color: Colors.grey),
              ),
            ),
    );
  }
}
