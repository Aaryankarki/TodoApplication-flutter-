// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  ToDo({required this.id, required this.todoText, this.isDone = false});
  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check Emails', isDone: true),
      ToDo(id: '04', todoText: 'Team Meeting', isDone: false),
      ToDo(id: '05', todoText: 'Work on Mobile App', isDone: false),
      ToDo(id: '06', todoText: 'Dinner with Supss', isDone: false),
    ];
  }
}

