import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = [];

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
  }

  void editTask(int index, String newTask) {
    setState(() {
      tasks[index] = newTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteTask(index),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController controller =
                      TextEditingController(text: tasks[index]);
                  return AlertDialog(
                    title: Text('Edit Task'),
                    content: TextField(
                      controller: controller,
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Save'),
                        onPressed: () {
                          editTask(index, controller.text);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: controller,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addTask(controller.text);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
