import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_social_app/models/Social_User_Model.dart';
import 'package:firebase_social_app/shared/components.dart';
import 'package:firebase_social_app/shared/cubit/app_cubit.dart';
import 'package:firebase_social_app/shared/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("New Feed" , style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0.0,

          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).model != null ,
            builder: (context){
              var modelx = AppCubit.get(context).model;
              return  Column(
                children: [
                  if(!(modelx!.isEmailVerified!))
                  Container(
                    color: Colors.amber.withOpacity(.6),
                    height: 50.0,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                                "Please verify your email"
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 20.0,
                          ),
                          defaultTextButton(function: (){}, text: "send")
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }, fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
          },
          ),
        );
      },
    );
  }
}
