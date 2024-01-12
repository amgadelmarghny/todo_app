import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/model/tast_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskModel.id.toString()),
      onDismissed: (direction) {
        BlocProvider.of<AppCubit>(context)
            .deleteFromDatabase(id: taskModel.id!);
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            child: Text(
              taskModel.time,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskModel.title,
                maxLines: 2,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                taskModel.date,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1B5E20),
                ),
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              BlocProvider.of<AppCubit>(context)
                  .updateDatabase(status: 'done', id: taskModel.id!);
            },
            icon: const Icon(
              Icons.check_box_outlined,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<AppCubit>(context)
                  .updateDatabase(status: 'archive', id: taskModel.id!);
            },
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
