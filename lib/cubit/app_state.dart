part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class NavBarState extends AppState {}

final class BottomSheetState extends AppState {}

final class CreatDatabaseState extends AppState {}

final class InsertIntoDatabaseState extends AppState {}

final class GetFromDatabaseState extends AppState {}

final class UpdateDatabaseState extends AppState {}

final class FailurState extends AppState {
  final String err;
<<<<<<< HEAD
  FailurState(this.err);
=======
   FailurState(this.err);
>>>>>>> b662048b32b1268cfd207fa787442ce91301a088
}

final class DeletFromDatabaseState extends AppState {}
