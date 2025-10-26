import 'package:grocery_app/src/domain/usecase/product/category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';
import '../../../../domain/usecase/user/sign_in_usecase.dart';
import '../../../bloc/base_state.dart';

class SubCategoryCubit extends Cubit<BaseState> {
  SubCategoryCubit(this.categoryUseCase) : super(const BaseState());

  final CategoryUseCase categoryUseCase;

  void fetchSubCategory(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth =
        await categoryUseCase.fetchSubCategory(MapParams({'id': id}));

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
