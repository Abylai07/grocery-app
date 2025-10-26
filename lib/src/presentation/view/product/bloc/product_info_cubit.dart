import 'package:grocery_app/src/domain/usecase/product/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';
import '../../../bloc/base_state.dart';

class ProductInfoCubit extends Cubit<BaseState> {
  ProductInfoCubit(this.productUseCase) : super(const BaseState());

  final ProductUseCase productUseCase;

  void fetchProductInfo(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await productUseCase.fetchProductInfo(PathParams(id.toString()));

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => BaseState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }
}
