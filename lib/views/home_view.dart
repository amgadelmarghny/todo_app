import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/componants/floating_button_method.dart';
import 'package:todo_app/componants/snack_bar.dart';
import 'package:todo_app/cubit/app_cubit.dart';

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
      //3-9-1989
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(appCubit.titleSceen[appCubit.curruntIndex]),
          ),
          body: appCubit.bodyScreens[appCubit.curruntIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appCubit.curruntIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              appCubit.changeButtonNavBar(index);
            },
            items: appCubit.buttomIcons,
          ),
          floatingActionButton: CustomFloatingActionButton(
            formKey: formKey,
            scaffoldKey: scaffoldKey,
          ),
        );
      },
    );
  }
}
