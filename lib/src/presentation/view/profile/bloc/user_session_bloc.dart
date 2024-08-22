
//Events
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/shared_preference.dart';

abstract class UserSessionEvent {}

class LoadUserSession extends UserSessionEvent {}

class LogoutUserSession extends UserSessionEvent {}

//State
abstract class UserSessionState {}

class UserSessionInitial extends UserSessionState {}

class UserSessionLoaded extends UserSessionState {
  final String? token;

  UserSessionLoaded(this.token);
}

class UserSessionLoggedOut extends UserSessionState {}

//BloC
class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionBloc() : super(UserSessionInitial()) {
    on<LoadUserSession>(_onLoadUserSession);
    on<LogoutUserSession>(_onLogoutUserSession);
  }

  void _onLoadUserSession(LoadUserSession event, Emitter<UserSessionState> emit) {
    final token = SharedPrefs().getAccessToken();
    if (token != null) {
      emit(UserSessionLoaded(token));
    } else {
      emit(UserSessionLoggedOut());
    }
  }

  void _onLogoutUserSession(LogoutUserSession event, Emitter<UserSessionState> emit) {
    SharedPrefs().deleteTokens();
    emit(UserSessionLoggedOut());
  }
}

