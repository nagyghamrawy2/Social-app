import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_social_app/models/Social_User_Model.dart';

import 'package:firebase_social_app/shared/constants.dart';
import 'package:firebase_social_app/shared/cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';



class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);


    SocialUserModel? model;
  void getUserData(){
    emit(SocialGetUserLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print(value.data());
          model = SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccess());
    })
        .catchError((onError){
          emit(SocialGetUserError(onError.toString()));
          print(onError.toString());
        });
  }


}
