import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/model/tast_model.dart';
import 'package:todo_app/views/widget_componants/task_item_list_view.dart';

class CustomConditionalBody extends StatelessWidget {
  const CustomConditionalBody({
    super.key,
    required this.taskModelList,
    required this.message,
  });

  final List<TaskModel> taskModelList;
  final String message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: taskModelList.isNotEmpty,
          builder: (BuildContext context) {
            return TaskItemListView(taskModelList: taskModelList);
          },
          fallback: (BuildContext context) {
            return Center(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
