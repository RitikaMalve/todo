import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TaskModel({required this.id, required this.title, this.isDone = false});

  TaskModel copyWith({String? title, bool? isDone}) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'isDone': isDone};

  @override
  List<Object?> get props => [id, title, isDone];
}
