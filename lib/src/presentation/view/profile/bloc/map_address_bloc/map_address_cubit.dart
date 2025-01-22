import 'package:abricoz_app/src/data/models/user/yandex_address.dart';
import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/address_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../common/enums.dart';

part 'map_address_state.dart';

class MapAddressCubit extends Cubit<MapAddressState> {
  MapAddressCubit(this.addressUseCase) : super(const MapAddressState());

  final AddressUseCase addressUseCase;

  void fetchAddress() async {
    emit(const MapAddressState(status: CubitStatus.loading));

    final failureOrAuth = await addressUseCase.fetchAddress();

    emit(
      failureOrAuth.fold(
        (l) => MapAddressState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => MapAddressState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  selectAddress(YandexAddress? address) {
    emit(state.copyWith(selectAddress: address));
  }

  addMapObject(MapObject object) {
    List<MapObject> mapObjects = List.from(state.mapObjects);
    mapObjects.add(object);
    emit(state.copyWith(mapObjects: mapObjects));
  }

  setInitState(){
    emit(const MapAddressState());
  }
}
