// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedlk/components/components.dart';
import 'package:schedlk/shared/cubit/cubit.dart';
import 'package:schedlk/shared/cubit/states.dart';


class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state)
      {
        var tasks = AppCubit.get(context).doneTasks;

        return tasksBuilder(
            tasks: tasks
        );
      },


    );
  }
}
