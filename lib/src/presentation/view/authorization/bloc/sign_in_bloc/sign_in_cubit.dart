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
        .signInPhone(MapParams({'phone': '+7$number',}));

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
      'phone': '+7$number',
      'code': code,
    }));

    emit(
      failureOrAuth.fold(
        (l) => SignInState(
          status: SignInStatus.error,
          message: l.message,
        ),
        (r) {
          final data = r;
          SharedPrefs().setId(r.id.toString());
          SharedPrefs().setPhone(number.trim());
          bool needName = data.firstname == null || data.lastname == null;
          if (!needName) {
            SharedPrefs().setFullName('${data.firstname} ${data.lastname}');
          }
          if (r.roles?.isNotEmpty == true) {
            List<String> roles = [];
            for (final item in r.roles!) {
              roles.add(item.name);
            }
            SharedPrefs().setRoles(roles);
          }
          return SignInState(
            status: needName
                ? SignInStatus.needName
                : SignInStatus.successCode,
            entity: r,
          );
        },
      ),
    );
  }

  void setName(String name, String surname) async {
    emit(const SignInState(status: SignInStatus.loading));

    final failureOrAuth = await signInUseCase.setName(MapParams({
      'firstname': name,
      'lastname': surname,
    }));

    emit(
      failureOrAuth.fold(
            (l) => SignInState(
          status: SignInStatus.error,
          message: l.message,
        ),
            (r) {
          SharedPrefs().setFullName('${r.firstname} ${r.lastname}');
          return SignInState(
            status: SignInStatus.successName,
            entity: r,
          );
        },
      ),
    );
  }
}
