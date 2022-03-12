
// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedlk/moduels/tasks/archived_Tasks/archived_tasks.dart';
import 'package:schedlk/moduels/tasks/new_Tasks/new_tasks.dart';
import 'package:schedlk/shared/cubit/states.dart';

import 'package:sqflite/sqflite.dart';

import '../../moduels/tasks/done_Tasks/done_tasks.dart';

class AppCubit extends Cubit <AppStates>
{
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;


  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  List<Widget> screens =
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  late   Database database ;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

void changeIndex(int index)
{
  currentIndex = index ;
  emit(AppChangeBottomNavBarStates());

}


  void createDataBase()
  {
     openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database ,version)
        {
          print('database created');


          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , data TEXT , data TEXT , time TEXT , status TEXT)')

              .then((value)
          {
            print('table created');

          }).catchError((error)
          {
            print('error when creating table  ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getDataFromDataBase(database);
          print('database opened');
        }).then((value)
     {
       database = value ;
       emit(AppCreateDataBaseStates());
     });


  }

   insertToDataBase
      ({
    required String title ,
    required String time ,
    required String date ,

  }) async {
    return await database.transaction((txn)
    {
      return  txn.rawInsert(
          'INSERT INTO tasks(title , date , time ,status ) VALUES ("$title" , "$date" , "$time" , "new" )'
      )
          .then((value)
      {
        print('$value Inserted Successfully');
        emit(AppInsertDataBaseStates());

        getDataFromDataBase(database);
      })
          .catchError((error)
      {
        print('error when Inserting table  ${error.toString()}');
      });


    });
  }


 void getDataFromDataBase(database)
  {
        newTasks= [];
        doneTasks= [];
        archivedTasks= [];
   emit(AppGetDataBaseLoadingStates());
    database.rawQuery('SELECT * FROM tasks').then((value)
   {
       value.forEach((element)
     {
       if(element['status'] == 'new') {
         newTasks.add(element);
       }else if(element['status'] == 'done') {
         doneTasks.add(element);
       }else {
         archivedTasks.add(element);
       }
     });
     emit(AppGetDataBaseStates());
   });
   ;
  }


void updateData({
  required String status,
  required int id,
})async
{


 database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status' , id ],
  ).then((value)
 {
   getDataFromDataBase(database);
   emit(AppUpdateDataBaseStates());

 });

}

  void deleteData({
    required int id,
  })async
  {


    database.rawDelete('DELETE FROM Test WHERE name = ?', ['another name'])
        .then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseStates());

    });

  }





  bool isBottomSheetShow = false ;
  IconData fabIcon = Icons.edit ;


  void changeBottomSheetState({
  required bool isShow ,
    required IconData icon ,
})
  {
    isBottomSheetShow = isShow ;
    fabIcon = icon ;
    emit(AppChangeBottomSheetStates());

  }
}