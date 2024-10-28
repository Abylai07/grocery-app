import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/city_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/user_usercase.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';

class PolygonCubit extends Cubit<BaseState> {
  PolygonCubit(this.cityUseCase) : super(const BaseState());

  final CityUseCase cityUseCase;

  void getCityPolygon() async {
  //  emit(const BaseState(status: CubitStatus.loading));

    int? id = SharedPrefs().getCityId();
    final failureOrAuth =
        await cityUseCase.getCityPolygon(PathParams(id.toString()));

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
