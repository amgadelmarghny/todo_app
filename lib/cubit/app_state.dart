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
  FailurState(this.err);
}

final class DeletFromDatabaseState extends AppState {}
