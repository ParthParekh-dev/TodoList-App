import 'package:flutter/material.dart';
import 'package:local_db/database_manager.dart';
import 'package:local_db/dialog_box.dart';
import 'package:local_db/task_card.dart';
import 'package:local_db/task_model.dart';

class TaskApp extends StatefulWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  _TaskAppState createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  final DatabaseManager databaseManager = DatabaseManager();

  late TaskModel taskModel;
  late List<TaskModel> taskList;
  TextEditingController taskInput = TextEditingController();
  late FocusNode taskFocusNode;

  @override
  void initState() {
    taskFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    taskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogBox().dialog(
                  context: context,
                  onPressed: () {
                    TaskModel taskModel = TaskModel(task: taskInput.text);
                    databaseManager.insertTask(taskModel);
                    setState(() {
                      taskInput.text = "";
                    });
                    Navigator.of(context).pop();
                  },
                  taskController: taskInput,
                  taskFocusNode: taskFocusNode,
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: databaseManager.getTaskList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            taskList = snapshot.data as List<TaskModel>;
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                TaskModel taskModel = taskList[index];
                return TaskCard(
                  taskModel: taskModel,
                  taskInput: taskInput,
                  onDeletePress: () {
                    databaseManager.deleteTask(taskModel);
                    setState(() {});
                  },
                  onEditPress: () {
                    taskInput.text = taskModel.task;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogBox().dialog(
                              context: context,
                              onPressed: () {
                                databaseManager.updateTask(TaskModel(
                                  id: taskModel.id,
                                  task: taskInput.text,
                                ));
                                setState(() {
                                  taskInput.text = "";
                                });
                                Navigator.of(context).pop();
                              },
                              taskController: taskInput);
                        });
                  },
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
