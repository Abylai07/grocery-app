import 'package:flutter_bloc/flutter_bloc.dart';

class EmailValidationCubit extends Cubit<bool> {
  EmailValidationCubit() : super(true); // Initially, assume the email is valid

  void validateEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    emit(emailRegex.hasMatch(email));
  }
}
