import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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

  void changButtonNavBar(int index) {
    curruntIndex = index;
    emit(ChangeNavBarState());
  }
  ///////////////////
  Database? database;

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
        debugPrint('Database opened');
      },
    ).then((value) {
      emit(CreatDatabaseState());
    }).catchError((err) {
      debugPrint('Failed to insert into Database : $err');
    });
  }

  //Insert some records in a transaction
  void insertIntoDatabase(
      {required String title, required String time, required String date}) {
    database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time","$date", "new")');
    }).then((value) {
      debugPrint('Database inserted successfully : $value');
      emit(InsertIntoDatabaseState());
    }).catchError((err) {
      debugPrint('Failed to insert into Database : $err');
    });
  }

  //Get the tasks
  void getFromDatabase() {
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      for (var list in value) {}
      emit(GetFromDatabaseState());
    }).catchError((err) {
      debugPrint('Failed to fetch data from Database : $err');
    });
  }

  // Update tasks
  void updateDatabase({required String status, required int id}) {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      emit(UpdateDatabaseState());
    });
  }

  void deleteFromDatabase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeletFromDatabaseState());
    });
  }
}
