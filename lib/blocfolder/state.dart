import 'package:blog_todoapp/model/model.dart';

class TodoState {
  final List<TaskModel> tasks;

  TodoState({required this.tasks});

  TodoState copyWith({List<TaskModel>? tasks}) {
    return TodoState(tasks: tasks ?? this.tasks);
  }

  Map<String, dynamic> toMap() {
    return {'tasks': tasks.map((t) => t.toJson()).toList()};
  }

  factory TodoState.fromMap(Map<String, dynamic> map) {
    return TodoState(
      tasks: List<TaskModel>.from(
        map['tasks']?.map((x) => TaskModel.fromJson(x)),
      ),
    );
  }
}
