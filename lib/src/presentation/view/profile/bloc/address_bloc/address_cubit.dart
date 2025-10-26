import 'package:grocery_app/src/domain/entity/user/address_entity.dart';
import 'package:grocery_app/src/domain/usecase/product/category_usecase.dart';
import 'package:grocery_app/src/domain/usecase/user/address_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/usecase/product/product_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addressUseCase) : super(const AddressState());

  final AddressUseCase addressUseCase;

  void fetchAddress() async {
    emit(const AddressState(status: CubitStatus.loading));

    final failureOrAuth = await addressUseCase.fetchAddress();

    emit(
      failureOrAuth.fold(
        (l) => AddressState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => AddressState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  void addAddress({int? addressId, required Map<String, dynamic> data}) async {
    emit(const AddressState(status: CubitStatus.loading));

    final failureOrAuth = await addressUseCase.createAddress(
      PathMapParams(path: addressId != null ? 'update/$addressId' : 'store', data: data),
    );

    emit(
      failureOrAuth.fold(
        (l) => AddressState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => AddressState(
          status: CubitStatus.success,
          entity: [r],
        ),
      ),
    );
  }

  void deleteAddress(int? addressId) async {
    emit(const AddressState(status: CubitStatus.loading));

    final failureOrAuth = await addressUseCase.deleteAddress(PathParams(addressId.toString()));

    emit(
      failureOrAuth.fold(
            (l) => AddressState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => const AddressState(
          status: CubitStatus.success,
        ),
      ),
    );
  }

  selectAddress(AddressEntity? city) {
    emit(state.copyWith(selectDistrict: city));
  }
}
