import 'package:abricoz_app/src/domain/usecase/user/city_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../common/utils/shared_preference.dart';
import '../../../../../domain/entity/user/city_model.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.cityUseCase) : super(const CityState());

  final CityUseCase cityUseCase;

  void fetchCityList() async {
    emit(const CityState(status: CubitStatus.loading));

    final failureOrAuth = await cityUseCase.getCity();

    emit(
      failureOrAuth.fold(
        (l) => CityState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          int? cityId = SharedPrefs().getCityId();
          CityEntity? city;

          if (cityId != null) {
            city = r.firstWhere((element) => element.id == cityId);
          }

          return CityState(
            status: CubitStatus.success,
            entity: r,
            selectCity: city ?? r.first,
          );
        }
      ),
    );
  }

  selectCity(CityEntity? city) {
    SharedPrefs().setCityId(city?.id);
    emit(state.copyWith(selectCity: city));
  }
}
