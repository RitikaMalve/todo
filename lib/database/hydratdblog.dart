import 'package:blog_todoapp/blocfolder/state.dart';
import 'package:blog_todoapp/blocfolder/task.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(tasks: [])) {
    on<AddTask>((event, emit) {
      final updated = [...state.tasks, event.task];
      emit(state.copyWith(tasks: updated));
    });

    on<UpdateTask>((event, emit) {
      final updated =
          state.tasks.map((task) {
            return task.id == event.task.id ? event.task : task;
          }).toList();
      emit(state.copyWith(tasks: updated));
    });

    on<DeleteTask>((event, emit) {
      final updated = state.tasks.where((task) => task.id != event.id).toList();
      emit(state.copyWith(tasks: updated));
    });
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toMap();
  }
}
