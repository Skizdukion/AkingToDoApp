import 'models/task.dart';

final fakeDataTask = {
  TaskModel(taskId: '1', time: DateTime(2021, 7, 1, 9, 30), title: 'Random title No 1', isDone: true),
  TaskModel(taskId: '2', time: DateTime(2021, 7, 1, 11, 30), title: 'Random title No 2'),
  TaskModel(taskId: '3', time: DateTime(2021, 7, 2, 15, 30), title: 'Random title No 3'),
  TaskModel(taskId: '4', time: DateTime(2021, 7, 2, 21, 30), title: 'Random title No 4', isDone: true),
  TaskModel(taskId: '5', time: DateTime(2021, 7, 4, 6, 30), title: 'Random title No 5'),
  TaskModel(taskId: '6', time: DateTime(2021, 7, 5, 7, 30), title: 'Random title No 6', isDone: true),
  TaskModel(taskId: '7', time: DateTime(2021, 7, 6, 15, 30), title: 'Random title No 7'),
  TaskModel(taskId: '8', time: DateTime(2021, 7, 7, 11, 30), title: 'Random title No 8'),
  TaskModel(taskId: '9', time: DateTime(2021, 7, 10, 20, 30), title: 'Random title No 9'),
  TaskModel(taskId: '10', time: DateTime(2021, 7, 12, 21, 30), title: 'Random title No 10'),
  TaskModel(taskId: '11', time: DateTime(2021, 7, 13, 7, 30), title: 'Random title No 11'),
  TaskModel(taskId: '12', time: DateTime(2021, 7, 14, 9, 30), title: 'Random title No 12', isDone: true),
  TaskModel(taskId: '13', time: DateTime(2021, 7, 14, 10, 30), title: 'Random title No 13'),
  TaskModel(taskId: '14', time: DateTime(2021, 7, 14, 11, 30), title: 'Random title No 14'),
  TaskModel(taskId: '15', time: DateTime(2021, 7, 15, 12, 30), title: 'Random title No 15', isDone: true),
  TaskModel(taskId: '16', time: DateTime(2021, 7, 15, 13, 30), title: 'Random title No 16'),
  TaskModel(taskId: '17', time: DateTime(2021, 7, 16, 19, 30), title: 'Random title No 17'),
  TaskModel(taskId: '18', time: DateTime(2021, 7, 17, 14, 30), title: 'Random title No 18', isDone: true),
  TaskModel(taskId: '19', time: DateTime(2021, 7, 20, 4, 30), title: 'Random title No 19'),
  TaskModel(taskId: '20', time: DateTime(2021, 7, 22, 13, 30), title: 'Random title No 20', isDone: true),
  TaskModel(taskId: '21', time: DateTime(2021, 7, 25, 13, 30), title: 'Random title No 21'),
  TaskModel(taskId: '22', time: DateTime(2021, 7, 27, 13, 30), title: 'Random title No 22'),
  TaskModel(taskId: '23', time: DateTime(2021, 7, 29, 13, 30), title: 'Random title No 23', isDone: true),
  TaskModel(taskId: '24', time: DateTime(2021, 7, 15, 14, 30), title: 'Random title No 24', isDone: true),
  TaskModel(taskId: '25', time: DateTime(2021, 7, 15, 15, 30), title: 'Random title No 25'),
  TaskModel(taskId: '26', time: DateTime(2021, 7, 15, 16, 30), title: 'Random title No 26', isDone: true),
};


abstract class TaskRepository{
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime);
  List<TaskModel> getTaskListForDay(String userID, DateTime date);
  bool changeTaskDoneState(String taskId);
  void deleteTask(String taskId);
  // void checkDoneState(String taskId);
  const TaskRepository();
}

class FakeTaskRepository extends TaskRepository{
  const FakeTaskRepository();
  static var taskList = fakeDataTask;

  @override
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime) {
    List<TaskModel> returnList = [];
    fakeDataTask.forEach((val) {
      if(val.time.isAfter(startTime)&&val.time.isBefore(endTime)) {
        returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  List<TaskModel> getTaskListForDay(String userID, DateTime date) {
    List<TaskModel> returnList = [];
    fakeDataTask.forEach((val) {
      if((val.time.day == date.day)&&(val.time.month == date.month)&&(val.time.year == date.year)) {
        // print('${val.taskId} ${val.isDone}');
        returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  bool changeTaskDoneState(String taskId){
    bool result = false;
    fakeDataTask.forEach((val) {
      if(val.taskId == taskId){
        val.isDone = !val.isDone;
        result = true;
      }
    });
    return result;
  }

  @override
  void deleteTask(String taskId) {
    fakeDataTask.remove(getTask(taskId));
  }

  TaskModel? getTask(String taskId){
    TaskModel? result;
    fakeDataTask.forEach((val) {
      if(val.taskId == taskId){
        result = val;
      }
    });
    return result;
  }
}