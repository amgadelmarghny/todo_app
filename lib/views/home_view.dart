import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/app_cubit.dart';
import 'package:todo_app/views/widget_componants/task_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(appCubit.titleSceen[appCubit.curruntIndex]),
          ),
          body: appCubit.bodyScreens[appCubit.curruntIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              appCubit.changeButtonNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasts'),
              BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'archive'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (appCubit.isBottomSheetShow) {
                scaffoldKey.currentState!.showBottomSheet((context) {
                  return const TaskSheet();
                });
                appCubit.changeBottomSheet(Icons.add, false);
              } else {
                Navigator.pop(context);
                appCubit.changeBottomSheet(Icons.edit, true);
              }
            },
            child: Icon(appCubit.fabIcon),
          ),
        );
      },
    );
  }
}
