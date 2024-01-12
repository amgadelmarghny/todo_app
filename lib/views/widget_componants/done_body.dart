import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/model/tast_model.dart';
import 'package:todo_app/views/widget_componants/task_item_list_view.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel>taskModelList = BlocProvider.of<AppCubit>(context).doneTaskModelList;
    return TaskItemListView(taskModelList: taskModelList);
  }
}