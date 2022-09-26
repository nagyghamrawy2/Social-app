import 'package:firebase_social_app/layout/social_app/HomePage.dart';
import 'package:firebase_social_app/modules/social_login_screen/cubit/cubit.dart';
import 'package:firebase_social_app/modules/social_login_screen/cubit/states.dart';
import 'package:firebase_social_app/modules/social_register_screen/social_register_screen1.dart';

import 'package:firebase_social_app/shared/components.dart';
import 'package:firebase_social_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SocialLayout()), (route) => false);

            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                      'LOGIN',
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Login now to communicate with friends',
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email address must not be empty';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: SocialLoginCubit
                          .get(context)
                          .isPassword,
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          // SocialLoginCubit.get(context).userLogin(
                          //   email: emailController.text,
                          //   password: passwordController.text,
                          // );
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                              SocialLoginCubit
                                  .get(context)
                                  .isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                          onPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! SocialLoginLoadingState,
                      builder: (context) =>
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              color: Colors.blue,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                      fallback: (context) => CircularProgressIndicator(),
                    ),
                    SizedBox(height: 20,),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            InkWell(
                              focusColor: Colors.blue,
                              child: Text("Register"),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SocialRegisterScreen()));
                              },
                            )
                            ]
                    ),
                  ]
                  ),
                ),
              ),
            ),
          )
          );
        },
      ),
    );
  }
}
