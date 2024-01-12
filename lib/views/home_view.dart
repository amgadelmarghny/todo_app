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
  bool isBottomSheetShow = true;
  IconData fabIcon = Icons.edit;

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
              appCubit.changButtonNavBar(index);
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
              if (isBottomSheetShow) {
                scaffoldKey.currentState!.showBottomSheet((context) {
                  return const TaskSheet();
                });
                fabIcon = Icons.add;
                isBottomSheetShow = false;
              } else {
                Navigator.pop(context);
                fabIcon = Icons.edit;
                isBottomSheetShow = true;
              }
            },
            child: Icon(fabIcon),
          ),
        );
      },
    );
  }
}
