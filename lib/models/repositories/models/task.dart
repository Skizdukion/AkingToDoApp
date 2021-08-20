class TaskModel {
  final String title;
  final DateTime time;
  final taskId;
  final userId;
  final DateTime? dueDate;
  final String description;
  List<String> memberList;
  List<String> projectList;
  bool isDone;

  TaskModel({
    required this.title,
    required this.time, 
    required this.taskId, 
    required this.userId,
    this.isDone = false, 
    this.dueDate,
    this.description = '',
    this.memberList = const [],
    this.projectList = const [],
  });
}
