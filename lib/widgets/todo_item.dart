import 'package:flutter/material.dart';
import 'package:todo_application/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function updateTodo;

  const TodoItem(this.todo, this.updateTodo, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration:
              todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        todo.date.toString(),
        style: TextStyle(
          decoration:
              todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        icon:
            Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
        onPressed: () {
          updateTodo(todo);
        },
      ),
    );
  }
}
