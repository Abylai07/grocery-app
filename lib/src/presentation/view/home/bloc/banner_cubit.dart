import 'package:grocery_app/src/domain/usecase/user/banner_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';
import '../../../../domain/usecase/user/sign_in_usecase.dart';
import '../../../bloc/base_state.dart';

class BannerCubit extends Cubit<BaseState> {
  BannerCubit(this.bannerUseCase) : super(const BaseState());

  final BannerUseCase bannerUseCase;

  void fetchBanners() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await bannerUseCase(const MapParams({}));

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
