import 'package:blog_todoapp/custom/ConstantColor.dart';
import 'package:blog_todoapp/custom/showDeleteConfirmationPopup.dart.dart';
import 'package:blog_todoapp/custom/showtaskinputebottomsheet.dart';
import 'package:blog_todoapp/database/hydratdblog.dart';
import 'package:blog_todoapp/model/model.dart';
import 'package:blog_todoapp/blocfolder/state.dart';
import 'package:blog_todoapp/blocfolder/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool _isCompletedTasksVisible = true;
  bool _isPendingTasksVisible = true;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: secondarycolor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Todo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: secondarycolor,
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            final incompleteTasks =
                state.tasks.where((t) => !t.isDone).toList().reversed.toList();
            final completedTasks =
                state.tasks.where((t) => t.isDone).toList().reversed.toList();

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (incompleteTasks.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Pending Tasks', style: customtext),
                          trailing: IconButton(
                            icon: Icon(
                              _isPendingTasksVisible
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPendingTasksVisible =
                                    !_isPendingTasksVisible;
                              });
                            },
                          ),
                        ),
                        if (_isPendingTasksVisible)
                          SlidableAutoCloseBehavior(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: incompleteTasks.length,
                              itemBuilder: (context, index) {
                                final task = incompleteTasks[index];
                                return _buildTaskTile(context, task, true);
                              },
                            ),
                          ),
                      ],
                    ),
                  if (completedTasks.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Completed Tasks', style: customtext),
                          trailing: IconButton(
                            icon: Icon(
                              _isCompletedTasksVisible
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onPressed: () {
                              setState(() {
                                _isCompletedTasksVisible =
                                    !_isCompletedTasksVisible;
                              });
                            },
                          ),
                        ),
                        if (_isCompletedTasksVisible)
                          SlidableAutoCloseBehavior(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: completedTasks.length,
                              itemBuilder: (context, index) {
                                final task = completedTasks[index];
                                return _buildTaskTile(context, task, false);
                              },
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: customwhite,
          onPressed: () {
            showTaskInputBottomSheet(
              context: context,
              title: 'New Task',
              actionLabel: 'Add',
              onSubmit: (text) {
                final task = TaskModel(id: const Uuid().v4(), title: text);
                context.read<TodoBloc>().add(AddTask(task));
              },
            );
          },
          child: Icon(Icons.add, color: primarycolor),
        ),
      ),
    );
  }

  Widget _buildTaskTile(BuildContext context, TaskModel task, bool tsak) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Slidable(
        key: ValueKey(task.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            if (tsak)
              SlidableAction(
                onPressed:
                    (_) => showTaskInputBottomSheet(
                      context: context,
                      title: 'Edit Task',
                      actionLabel: 'Save',
                      initialText: task.title,
                      onSubmit: (updatedTitle) {
                        final updatedTask = task.copyWith(title: updatedTitle);
                        context.read<TodoBloc>().add(UpdateTask(updatedTask));
                      },
                    ),
                backgroundColor: primarycolor.withOpacity(0.9),
                foregroundColor: customwhite,
                icon: Icons.edit_square,
              ),
            SlidableAction(
              onPressed: (_) {
                showDeleteConfirmationPopup(context, () {
                  context.read<TodoBloc>().add(DeleteTask(task.id));
                });
              },
              backgroundColor: customredcolor,
              foregroundColor: customwhite,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              context.read<TodoBloc>().add(
                UpdateTask(task.copyWith(isDone: !task.isDone)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isDone ? primarycolor : primarycolor,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 8,
                backgroundColor: task.isDone ? primarycolor : customwhite,
                child:
                    task.isDone
                        ? Icon(Icons.check, color: customwhite, size: 10)
                        : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
