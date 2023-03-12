import 'package:flutter/material.dart';
import 'package:local_db/database_manager.dart';
import 'package:local_db/task_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final TextEditingController taskInput;
  final Function() onDeletePress;
  final Function() onEditPress;

  const TaskCard(
      {Key? key,
      required this.taskModel,
      required this.taskInput,
      required this.onDeletePress,
      required this.onEditPress})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final DatabaseManager databaseManager = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.taskModel.task,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: widget.onEditPress,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: widget.onDeletePress,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
