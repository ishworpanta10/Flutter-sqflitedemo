import 'package:flutter/material.dart';
import 'package:sqflite_demo/model/TaskModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sqflite Demo",
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  List<TaskModel> tasks = [];
  final TodoHelper _todoHelper = TodoHelper();

  TaskModel currentTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Sqflite Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: textController,
              ),
              FlatButton(
                onPressed: () {
                  currentTask = TaskModel(name: textController.text);
                  _todoHelper.insertTask(currentTask);
                },
                child: Text("Insert"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () async {
                  List<TaskModel> list = await _todoHelper.getallTask();
                  setState(() {
                    tasks = list;
                  });
                },
                child: Text("Show All Task"),
                color: Colors.red,
                textColor: Colors.white,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text("$tasks{index].id}"),
                          title: Text("$tasks{index}.name}"),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: tasks.length))
            ],
          ),
        ),
      ),
    );
  }
}
