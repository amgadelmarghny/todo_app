import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/views/widget_componants/task_sheet.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.formKey,
    required this.scaffoldKey,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = BlocProvider.of<AppCubit>(context);
    return FloatingActionButton(
      onPressed: () {
        if (appCubit.isBottomSheetShow) {
          widget.scaffoldKey.currentState!
              .showBottomSheet((context) {
                return TaskSheet(
                  formKey: widget.formKey,
                  autovalidateMode: autovalidateMode,
                );
              })
              .closed
              .then((value) {
                appCubit.changeBottomSheet(Icons.edit, true);
              });
          appCubit.changeBottomSheet(Icons.add, false);
        } else {
          if (widget.formKey.currentState!.validate()) {
            BlocProvider.of<AppCubit>(context).insertIntoDatabase(
              title: appCubit.title!,
              time: appCubit.time!,
              date: appCubit.date!,
            );
            appCubit.changeBottomSheet(Icons.edit, true);
          } else {
            autovalidateMode = AutovalidateMode.always;
            setState(() {});
          }
        }
      },
      child: Icon(appCubit.fabIcon),
    );
  }
}
