// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:schedlk/components/components.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emilController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Text('login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black54

                      ),

                    ),
                SizedBox(
                      height: 20,
                    ),
                 defaultTextFormField(
                     controller: emilController,
                     type: TextInputType.emailAddress,
                     validate: (value)
                     {
                       if( value == null || value.isEmpty)
                         {
                           return ' email must not be empty';
                         }
                       return null ;
                     },
                     label: 'Email Address',
                     prefix: Icons.email

                 ),
                    SizedBox(
                      height: 20,
                    ),

                    defaultTextFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                        isPassword: isPassword ,
                        suffixPressed: ()
                        {
                          setState(() {

                            isPassword = !isPassword;
                          });
                        },
                        validate: (value)
                        {

                          if(value == null || value.isEmpty)
                          {
                            return ' password must not be empty';
                          }
                          return null ;
                        },


                    ),
                    SizedBox(
                      height: 20,
                    ),

                Container(
                  width:double.infinity,
                  height: 40,
                  child: MaterialButton(
                    height: 40,
                    onPressed: ()
                    {
                      if(formKey.currentState?.validate() != null )
                            {

                              print(emilController.text);
                              print(passwordController.text);
                            }
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                          color: Colors.white

                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)

                  ),

                ),


                    // defaultButton(
                    //
                    //   text: 'login',
                    //     width: double.infinity,
                    //     background: Colors.teal,
                    //     function: (){
                    //       if(formKey.currentState?.validate() != null )
                    //       {
                    //
                    //         print(emilController.text);
                    //         print(passwordController.text);
                    //       }
                    //
                    //
                    //
                    //     },
                    //
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do not  have an account ? ',
                          style: TextStyle(
                          ),
                        ),
                        TextButton(
                            onPressed: (){},
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.blue,

                              ),
                            )
                        ),

                      ],
                    )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
