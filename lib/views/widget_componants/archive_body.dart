import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/componants/custom_conditional_body.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/model/tast_model.dart';

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> taskModelList =
        BlocProvider.of<AppCubit>(context).archiveTaskModelList;
    return CustomConditionalBody(taskModelList: taskModelList, message: 'Archive some tasks');
  }
}
