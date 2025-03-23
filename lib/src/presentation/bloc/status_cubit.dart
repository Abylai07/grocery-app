import 'package:abricoz_app/src/domain/usecase/user/app_status_use_case.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/enums.dart';

class AppSettingsCubit extends Cubit<BaseState> {
  AppSettingsCubit(this._useCase) : super(const BaseState());

  final AppStatusUseCase _useCase;

  Future fetchAppStatus() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await _useCase(null);

    emit(
      failureOrAuth.fold(
          (l) => BaseState(
                status: CubitStatus.error,
                message: l.message,
              ), (r) {
        return BaseState(
          status: CubitStatus.success,
          entity: r,
        );
      }),
    );
  }
}
