import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/model/tast_model.dart';
import 'package:todo_app/views/widget_componants/task_item.dart';

class TaskItemListView extends StatelessWidget {
  const TaskItemListView({
    super.key,
    required this.taskModelList,
  });

  final List<TaskModel> taskModelList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: taskModelList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: taskModelList[index],
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                color: Colors.white38,
                height: 1,
              );
            },
          ),
        );
      },
    );
  }
}
