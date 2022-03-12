// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, use_key_in_widget_constructors


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedlk/components/components.dart';
import 'package:schedlk/moduels/login_screen.dart';
import 'package:schedlk/shared/cubit/cubit.dart';
import 'package:schedlk/shared/cubit/states.dart';




class HomeLayOut extends StatelessWidget

{



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context, AppStates state)
        {
          if( state is AppInsertDataBaseStates)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context, AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);

         return Scaffold(
            key:scaffoldKey ,
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currentIndex]
              ),
            ),
            body:  ConditionalBuilder (


              condition: state is! AppGetDataBaseLoadingStates,
              builder: (BuildContext context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),

            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,

                        ),
                      )
                  ),
                  ListTile(
                    leading: Icon(Icons.home,),title:  Text('Main'),onTap: (){},),
                  ListTile(
                    leading: Icon(Icons.supervised_user_circle_rounded,),title:  Text('Log in'),onTap: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },),
                  ListTile(
                    leading: Icon(Icons.verified_user_outlined,),title:  Text('User'),onTap: (){},),
                  ListTile(
                    leading: Icon(Icons.logout,),title:  Text('log out'),onTap: (){},),
                ],
              ),
            ),
            floatingActionButton: SingleChildScrollView(

              child: FloatingActionButton(
                onPressed: ()
                {
                  if(cubit.isBottomSheetShow)
                  {
                    if(formKey.currentState!.validate())
                    {
                      cubit.insertToDataBase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text,
                      );

                    }
                  }else
                  {
                    scaffoldKey.currentState!.showBottomSheet((context) => Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String ?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'title must not be empty';
                                  }
                                  return null ;
                                },
                                label: 'Task title',
                                prefix: Icons.title,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                onTap: ()
                                {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value)
                                  {
                                    timeController.text = value!.format(context);
                                    print(value.format(context));
                                  });
                                },
                                validate: (String ?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'time must not be empty';
                                  }
                                  return null ;
                                },
                                label: 'Task time',
                                prefix: Icons.timer,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextFormField(
                                controller: dateController,
                                type: TextInputType.datetime,
                                // onTap: () => _selectDate(context),

                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1995),
                                    lastDate:  DateTime.now().add(Duration(days: 365)),


                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                    print(DateFormat.yMMMd().format(value));
                                  });
                                },

                                validate: (String ?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'date must not be empty';
                                  }
                                  return null ;
                                },
                                label: 'Task Date',
                                prefix: Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                      elevation: 20,
                    ).closed.then((value)
                  {
                  cubit.changeBottomSheetState(
                  isShow: false,
                  icon: Icons.edit
                  );
                  });
                    cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add,
                    );
                  }

                },
                child:  Icon(cubit.fabIcon),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(

              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_box_outlined),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archive'
                ),
              ],

            ),

          );
        },


      ),
    );
  }



}

