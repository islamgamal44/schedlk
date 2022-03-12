
// ignore_for_file: prefer_const_constructors, avoid_print, body_might_complete_normally_nullable, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:schedlk/shared/cubit/cubit.dart';


Widget defaultButton ({
 required double width,
  required Color background ,
  required Function function ,
  required String text ,

}) =>  Container(
  width:double.infinity,
   height: 40,
child: MaterialButton(
  height: 40,
  onPressed: (){},
child: Text(
  text,
style: TextStyle(
color: Colors.white

),
),
),
  decoration: BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.circular(10)

  ),

);




Widget defaultTextFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  required  Function(String ? val ) validate ,
  required String label ,
  required IconData prefix,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  Function? suffixPressed,
  IconData ? suffix,
  bool isPassword = true ,
  bool isClickable = true ,


}) =>   TextFormField(
  controller:  controller,
  keyboardType: type,
  enabled:isClickable ,
  onFieldSubmitted: (s)
  {
    onSubmit!(s);
  },
  onChanged: (s)
  {
   onChange!(s);
  },
  onTap: (){
    onTap!();
  },

  validator: (String ? value)
  {
   return validate(value);
  },
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
        onPressed: (){
          suffixPressed!();
        },
        icon: Icon(suffix),
    ):null ,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)

    ),

  ),

);

Widget buildTaskItem(Map model ,context) => Dismissible(

  key: Key(model['id'].toString()),
  child:Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

              '${model['time']}'

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(



          child: Column(

            children: [

              Text(

          '${model['title']}',

                style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold

                ),

              ),

              Text(

                  '${model['date']}',

                style: TextStyle(

                    color: Colors.grey

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

       IconButton(

           onPressed: ()

           {

             AppCubit.get(context).updateData(

                 status: 'Done',

                 id: model['id']

             );

           },

           icon: Icon(Icons.check_box,

             color: Colors.green,

           )

       ),

       IconButton(

           onPressed: ()

           {



             AppCubit.get(context).updateData(

                 status: 'archived',

                 id: model['id']

             );

           },

           icon: Icon(Icons.archive,

             color: Colors.black12,

           )

       ),

      ],

    ),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(
        id: model['id']
    );
  },
);

Widget tasksBuilder ({

  required List<Map> tasks ,
}) => ConditionalBuilder(


condition: tasks.isNotEmpty,
builder: (BuildContext context) => ListView.separated(
itemBuilder: (context, index) => buildTaskItem(tasks[index] ,context) ,
separatorBuilder: (context, index) => Padding(
padding: const EdgeInsetsDirectional.only(
start: 20
),
child: Container(
width: double.infinity,
height: 1,
color: Colors.grey[300],
),
),
itemCount: tasks.length
),
fallback: (BuildContext context) => Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.menu,
size: 100,
color: Colors.grey,
),
Text(
'No tasks yet , please add some tasks ',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
color: Colors.grey,

),
)
],
),
),
);