class TaskModel {
  TaskModel({
    this.id,
    required this.task,
  });

  final int? id;
  final String task;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        task: json["task"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
      };
}
