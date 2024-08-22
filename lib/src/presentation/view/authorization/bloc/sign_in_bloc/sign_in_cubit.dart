import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/utils/shared_preference.dart';
import '../../../../../domain/usecase/user/sign_in_usecase.dart';

part 'sign_in_state.dart';
class SingInCubit extends Cubit<SignInState> {
  SingInCubit(this.signInUseCase) : super(const SignInState());

  final SignInUseCase signInUseCase;

  void signInPhone(String number) async {
    emit(const SignInState(status: SignInStatus.loading));

    final failureOrAuth = await signInUseCase
        .signInPhone(MapParams({'phone': number.trim()}));

    emit(
      failureOrAuth.fold(
        (l) => SignInState(
          status: SignInStatus.error,
          message: l.message,
        ),
        (r) => SignInState(
          status: SignInStatus.successPhone,
          entity: r,
        ),
      ),
    );
  }

  void signInCode(String number, String code) async {
    emit(const SignInState(status: SignInStatus.loading));

    final failureOrAuth = await signInUseCase.signInCode(MapParams({
      'phone': number.trim(),
      'code': code,
    }));

    if (failureOrAuth.isRight()) {
      final data = failureOrAuth.toOption().toNullable();
      SharedPrefs().setAccessToken(data?['data']['token']);
      SharedPrefs().setPhone(number.trim());
    }

    emit(
      failureOrAuth.fold(
        (l) => SignInState(
          status: SignInStatus.error,
          message: l.message,
        ),
        (r) => SignInState(
          status: SignInStatus.successCode,
          entity: r,
        ),
      ),
    );
  }
}
