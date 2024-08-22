import 'dart:developer';

import 'package:abricoz_app/src/domain/entity/user/district_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/district_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  DistrictCubit(this.districtUseCase) : super(const DistrictState());

  final DistrictUseCase districtUseCase;

  void fetchDistricts(int? districtId) async {
    emit(const DistrictState(status: CubitStatus.loading));

    final failureOrAuth = await districtUseCase.getDistricts();

    emit(
      failureOrAuth.fold(
        (l) => DistrictState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          DistrictEntity? entity;
          try{
            entity = r.firstWhere((item) => item.id == districtId);
          } catch(e){
            log(e.toString(), name: 'DistrictEntity select error');
          }
          return DistrictState(
            status: CubitStatus.success,
            entity: r,
            selectDistrict: entity ?? r.first,
          );
        }
      ),
    );
  }

  selectDistrict(DistrictEntity? city) {
    emit(state.copyWith(selectDistrict: city));
  }
}
