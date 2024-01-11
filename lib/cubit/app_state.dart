part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class ChangeNavBarState extends AppState {}

final class CreatDatabaseState extends AppState {}

final class InsertIntoDatabaseState extends AppState {}

final class GetFromDatabaseState extends AppState {}

final class UpdateDatabaseState extends AppState {}

final class DeletFromDatabaseState extends AppState {}
