import 'package:todo_app/models/providers/local_data.dart';

import 'models/task.dart';


abstract class TaskRepository{
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime);
  List<TaskModel> getTaskListForDay(String userID, DateTime date);
  bool changeTaskDoneState(String taskId);
  void deleteTask(String taskId);
  const TaskRepository();
}

class FakeTaskRepository extends TaskRepository{
  const FakeTaskRepository();
  static var localData = LocalDataProvider();
  static int getTaskType = 2;

  @override
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime) {
    List<TaskModel> returnList = [];
    localData.taskList.forEach((val) {
      if(val.time.isAfter(startTime)&&val.time.isBefore(endTime)) {
        if (getTaskType == 2) returnList.add(val);
        if ((getTaskType == 1)&&(val.isDone == true)) returnList.add(val);
        if ((getTaskType == 0)&&(val.isDone == false)) returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  List<TaskModel> getTaskListForDay(String userID, DateTime date) {
    List<TaskModel> returnList = [];
    localData.taskList.forEach((val) {
      if((val.time.day == date.day)&&(val.time.month == date.month)&&(val.time.year == date.year)) {
        if (getTaskType == 2) returnList.add(val);
        if ((getTaskType == 1)&&(val.isDone == true)) returnList.add(val);
        if ((getTaskType == 0)&&(val.isDone == false)) returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  bool changeTaskDoneState(String taskId){
    bool result = false;
    localData.taskList.forEach((val) {
      if(val.taskId == taskId){
        val.isDone = !val.isDone;
        result = true;
      }
    });
    return result;
  }

  @override
  void deleteTask(String taskId) {
    localData.taskList.remove(getTask(taskId));
  }

  TaskModel? getTask(String taskId){
    TaskModel? result;
    localData.taskList.forEach((val) {
      if(val.taskId == taskId){
        result = val;
      }
    });
    return result;
  }

  void addTask(TaskModel item){
    localData.taskList.add(item);
  }

  int getLength(){
    return localData.taskList.length;
  }

  void changeGetTaskType(int val){
    getTaskType = val;
  }
}