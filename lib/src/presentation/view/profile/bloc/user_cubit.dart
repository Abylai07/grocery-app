import 'package:grocery_app/src/domain/usecase/user/user_usercase.dart';
import 'package:grocery_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';


class UserCubit extends Cubit<BaseState> {
  UserCubit(this.userUseCase) : super(const BaseState());

  final UserUseCase userUseCase;

  void fetchUser() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userUseCase.fetchUser();

    emit(
      failureOrAuth.fold(
              (l) => BaseState(
            status: CubitStatus.error,
            message: l.message,
          ),
              (r) {
            return BaseState(
              status: CubitStatus.success,
              entity: r,
            );
          }
      ),
    );
  }

  void deleteAccount() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userUseCase.deleteUser();

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        }
      ),
    );
  }
}
