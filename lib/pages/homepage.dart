import 'package:flutter/material.dart';
import 'package:todoapplication/model/todo.dart';
import 'package:todoapplication/widget/todo_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDO = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDO = todosList;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 30),
                        child: Text("All Todos"),
                      ),
                      for (ToDo todo in _foundToDO)
                        TodoItems(
                          todo: todo,
                          onToDoChanged: _handleToDoChanged,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                    // height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          // offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _todoController,
                              decoration: InputDecoration(
                                hintText: "Add a new Todos",
                                border: InputBorder.none,
                              ),

                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  // width: 80,
                  margin: EdgeInsets.only(bottom: 0, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text("+", style: TextStyle(fontSize: 30)),
                    onPressed: () {
                      _addTheItem(_todoController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChanged(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTheItem(String toDo) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: _todoController.text,
        ),
      );
      _foundToDO = todosList;
      _todoController.clear();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (item) => item.todoText!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      _foundToDO = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 10,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: Colors.black, size: 40),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/image.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              // controller: _todoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 100,
                  minWidth: 40,
                ),
                border: InputBorder.none,
                hintText: 'Search....',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
