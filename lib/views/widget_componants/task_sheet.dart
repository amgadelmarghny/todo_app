import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/views/widget_componants/custom_text_field.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
  });
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          autovalidateMode: widget.autovalidateMode,
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Task Title',
                onChange: (data) {
                  BlocProvider.of<AppCubit>(context).title = data;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Task Time',
                textEditingController: timeController,
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    if (value != null) {
                      timeController.text = value.format(context);
                      BlocProvider.of<AppCubit>(context).time =
                          value.format(context);
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: dateController,
                hintText: 'Task Date',
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse('2035-01-01'),
                  ).then((value) {
                    if (value != null) {
                      dateController.text = DateFormat.yMMMd().format(value);
                      BlocProvider.of<AppCubit>(context).date =
                          DateFormat.yMMMd().format(value);
                    }
                  });
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
