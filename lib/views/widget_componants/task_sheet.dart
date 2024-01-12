import 'package:flutter/material.dart';
import 'package:todo_app/views/widget_componants/custom_text_field.dart';

class TaskSheet extends StatelessWidget {
  const TaskSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(hintText: 'Task Title'),
            SizedBox(height: 20),
            CustomTextField(hintText: 'Task Time'),
            SizedBox(height: 20),
            CustomTextField(hintText: 'Task Date'),
          ],
        ),
      ),
    );
  }
}
