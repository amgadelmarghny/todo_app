import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/componants/snack_bar.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is InsertIntoDatabaseState) {
          Navigator.pop(context);
        }
        if (state is FailurState) {
          customSnackBar(context: context, text: state.err);
        }
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
              floatingButtonTapMethod(appCubit, context);
            },
            child: Icon(appCubit.fabIcon),
          ),
        );
      },
    );
  }

  void floatingButtonTapMethod(AppCubit appCubit, BuildContext context) {
     if (appCubit.isBottomSheetShow) {
      scaffoldKey.currentState!
          .showBottomSheet((context) {
            return TaskSheet(
              formKey: formKey,
              autovalidateMode: autovalidateMode,
            );
          })
          .closed
          .then((value) {
            appCubit.changeBottomSheet(Icons.edit, true);
          });
      appCubit.changeBottomSheet(Icons.add, false);
    } else {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<AppCubit>(context).insertIntoDatabase(
          title: BlocProvider.of<AppCubit>(context).title!,
          time: BlocProvider.of<AppCubit>(context).time!,
          date: BlocProvider.of<AppCubit>(context).date!,
        );
        appCubit.changeBottomSheet(Icons.edit, true);
      } else {
        autovalidateMode = AutovalidateMode.always;
      }
    }
  }
}
