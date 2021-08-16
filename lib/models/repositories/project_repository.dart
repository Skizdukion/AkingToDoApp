import 'package:todo_app/models/providers/local_data.dart';
import 'models/project.dart';


abstract class ProjectRepository{
  List<ProjectModel> getPorjectList();
  void deleteProject(String projectId);
  void addProject(ProjectModel item);
  const ProjectRepository();
}

class FakeProjectRepository extends ProjectRepository{
  const FakeProjectRepository();
  static var localData = LocalDataProvider();

  @override
  void addProject(ProjectModel item) {
    localData.projectList.add(item);
  }

  @override
  void deleteProject(String projectId) {
    localData.projectList.remove(getProjectWithId(projectId));
  }

  ProjectModel? getProjectWithId(String projectId){
    ProjectModel? result;
    localData.projectList.forEach((val) {
      if(val.id == projectId){
        result = val;
      }
    });
    return result;
  }

  @override
  List<ProjectModel> getPorjectList() {
    return localData.projectList;
  }

  List<ProjectModel> getProjectListContainString(String searchString){
    List<ProjectModel>? tempList = []; 
    if(searchString != ''){
      for (var item in localData.projectList) {
        if (item.title.toLowerCase().contains(searchString.toLowerCase())){
          tempList.add(item);
        }
      }
    }
    else{ 
      tempList = []..addAll(localData.projectList);
    }
    return tempList;
  }
}