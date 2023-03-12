import 'package:flutter/material.dart';

class DialogBox {
  Widget dialog({
    required BuildContext context,
    required Function() onPressed,
    required TextEditingController taskController,
    FocusNode? taskFocusNode,
  }) {
    return AlertDialog(
      title: const Text("Enter Task"),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            TextFormField(
              controller: taskController,
              keyboardType: TextInputType.text,
              focusNode: taskFocusNode,
              decoration: const InputDecoration(hintText: "Task Name"),
              autofocus: true,
              onFieldSubmitted: (value) {
                taskFocusNode?.unfocus();
              },
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.blueGrey,
          child: const Text(
            "Cancel",
          ),
        ),
        MaterialButton(
          onPressed: onPressed,
          child: const Text("Submit"),
          color: Colors.blue,
        )
      ],
    );
  }
}
