import 'package:flutter/material.dart';
import 'package:todoapplication/model/todo.dart';

class TodoItems extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const TodoItems({
    super.key,
    required this.todo,
    this.onToDoChanged,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            iconSize: 18,
            color: Colors.white,
            onPressed: () {
              // print("Delete the code");
              onDeleteItem(todo.id);
            },
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
