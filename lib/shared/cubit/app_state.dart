abstract class AppState {}

class AppInitial extends AppState {}

class SocialGetUserSuccess extends AppState {}

class SocialGetUserLoading extends AppState {}

class SocialGetUserError extends AppState {
  final String error;
  SocialGetUserError(this.error);
}
