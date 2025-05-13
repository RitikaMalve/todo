import 'package:blog_todoapp/model/model.dart';

abstract class TodoEvent {}

class AddTask extends TodoEvent {
  final TaskModel task;
  AddTask(this.task);
}

class UpdateTask extends TodoEvent {
  final TaskModel task;
  UpdateTask(this.task);
}

class DeleteTask extends TodoEvent {
  final String id;
  DeleteTask(this.id);
}
