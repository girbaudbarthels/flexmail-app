import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flexmail_app/core/data/flexmail_api.dart';
import 'package:http/http.dart' as http;

abstract class MyState {}

class LoginState extends MyState {}

class UserLoggedInState extends MyState {}

abstract class MyEvent {}

class LoginEvent extends MyEvent {
  LoginEvent({required this.username, required this.accessToken});

  final String username;
  final String accessToken;
}

class UserLoggedInEvent extends MyEvent {}

class LoginBLoC extends Bloc<MyEvent, MyState> {
  LoginBLoC() : super(LoginState()) {
    on<UserLoggedInEvent>(isUserLoggedIn);
  }

  Future<void> isUserLoggedIn(UserLoggedInEvent event, Emitter emit) async {
    final status = await FlexmailApi.onInitApp();
    if (status == LoginStatus.loggedIn) {
      print('hier');
      emit(UserLoggedInState());
    }
  }
}
