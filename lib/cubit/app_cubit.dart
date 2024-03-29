import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/tast_model.dart';
import 'package:todo_app/views/widget_componants/archive_body.dart';
import 'package:todo_app/views/widget_componants/done_body.dart';
import 'package:todo_app/views/widget_componants/tasks_body.dart';
// import 'package:flutter/material.dart';

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
  List<BottomNavigationBarItem> buttomIcons = const [
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasts'),
    BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined), label: 'archive')
  ];
  bool isBottomSheetShow = true;
  IconData fabIcon = Icons.edit;

  void changeButtonNavBar(int index) {
    curruntIndex = index;
    emit(NavBarState());
  }

  void changeBottomSheet(IconData iconData, bool isShown) {
    fabIcon = iconData;
    isBottomSheetShow = isShown;
    emit(BottomSheetState());
  }

  ///////////////////////
  Database? database;
  String? title, time, date;
  List<TaskModel> addTaskModelList = [];
  List<TaskModel> doneTaskModelList = [];
  List<TaskModel> archiveTaskModelList = [];

  void creatDatabase() async {
    // open the database
    database = await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)');
        debugPrint('Database created');
      },
      onOpen: (database) {
        debugPrint('Database opened : ${database.toString()}');
        getFromDatabase(database);
      },
    ).then((value) {
      emit(CreatDatabaseState());
      return database = value;
      // ignore: body_might_complete_normally_catch_error
    }).catchError((err) {
      emit(FailurState('Failed to Creat into Database : $err'));
      debugPrint('Failed to Creat into Database : $err');
    });
  }

  //Insert some records in a transaction
  void insertIntoDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time","$date", "new")')
          .then((value) {
        debugPrint('Database inserted successfully : $value');
        emit(InsertIntoDatabaseState());
        getFromDatabase(database);
      }).catchError((err) {
        emit(FailurState('Failed to insert into Database : $err'));
        debugPrint('Failed to insert into Database : $err');
      });
    });
  }

  //Get the tasks
  void getFromDatabase(database) {
    addTaskModelList.clear();
    doneTaskModelList.clear();
    archiveTaskModelList.clear();
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      for (var list in value) {
        if (list['status'] == 'new') {
          addTaskModelList.add(TaskModel.fromSQflite(list));
        } else if (list['status'] == 'done') {
          doneTaskModelList.add(TaskModel.fromSQflite(list));
        } else {
          archiveTaskModelList.add(TaskModel.fromSQflite(list));
        }
      }
      emit(GetFromDatabaseState());
    }).catchError((err) {
      emit(FailurState('Failed to fetch data from Database : $err'));
      debugPrint('Failed to fetch data from Database : $err');
    });
  }

  // Update tasks
  void updateDatabase({required String status, required int id}) async {
    await database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getFromDatabase(database);
    }).catchError((err) {
      emit(FailurState('Error when update task : $err'));
    });
  }

  void deleteFromDatabase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
    }).catchError((err) {
      emit(FailurState('Error when delet task : $err'));
    });
  }
}
