//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_social_app/layout/social_app/HomePage.dart';
// import 'package:firebase_social_app/modules/social_login_screen/social_login_screen1.dart';
// import 'package:firebase_social_app/shared/constants.dart';
// import 'package:firebase_social_app/shared/cubit/app_cubit.dart';
// import 'package:firebase_social_app/shared/cubit/app_state.dart';
// import 'package:firebase_social_app/shared/network/local/cache_helper.dart';
// import 'package:firebase_social_app/shared/network/remote/dio_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   DioHelper.init();
//   await CacheHelper.init();
//   Widget widget;
//
//
//   if (uId != "") {
//     widget = SocialLayout();
//   } else {
//     widget = SocialLoginScreen();
//   }
//   runApp(MyApp(
//     startWidget: widget,
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   final Widget startWidget;
//
//   MyApp({required this.startWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (BuildContext context) => AppCubit(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: startWidget,
//       )
//       );
//
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_social_app/layout/social_app/HomePage.dart';
import 'package:firebase_social_app/shared/constants.dart';
import 'package:firebase_social_app/shared/cubit/app_cubit.dart';
import 'package:firebase_social_app/shared/network/local/cache_helper.dart';
import 'package:firebase_social_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/social_login_screen/social_login_screen1.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();




  Widget startWidget;

  if (uId != '')
  {
    startWidget=SocialLayout();
  }
  else {
    startWidget=SocialLoginScreen();
  }
  runApp(MyApp(startWidget: startWidget));



}
class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()..getUserData(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
        )
    );

  }
}

