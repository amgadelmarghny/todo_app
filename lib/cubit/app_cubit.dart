import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/views/widget_componants/archive_body.dart';
import 'package:todo_app/views/widget_componants/done_body.dart';
import 'package:todo_app/views/widget_componants/tasks_body.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  int curruntIndex = 0;
  List<String> titleSceen = [
    'Add tasks',
    'Done tasks',
    'Archeive tasks',
  ];
  List<Widget> bodyScreens = [
    const TasksBody(),
    const DoneTasks(),
    const ArchiveBody(),
  ];

  void changButtonNavBar(int index) {
    curruntIndex = index;
    emit(ChangeNavBarState());
  }
}
