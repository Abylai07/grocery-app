import 'package:abricoz_app/src/domain/entity/user/favorite_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/favorite_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/usecase/product/product_usecase.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteUseCase) : super(const FavoriteState());

  final FavoriteUseCase favoriteUseCase;

  void storeOrDeleteFavorite(bool isDelete, int id) async {

    final failureOrAuth = isDelete
        ? await favoriteUseCase.deleteFavorite(PathParams(id.toString()))
        : await favoriteUseCase.storeFavorite(MapParams({"product_id": id}));

    emit(
      failureOrAuth.fold(
        (l) => FavoriteState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          List<FavoriteEntity> newList = List<FavoriteEntity>.from(state.entity ?? []);

          if(isDelete){
            newList.removeWhere((item) => item.productId == id);
          } else if(r is FavoriteEntity){
            newList.add(r);
          }
          return FavoriteState(
            status: CubitStatus.success,
            entity: newList,
          );
        },
      ),
    );
  }

  void fetchFavorites() async {
    emit(const FavoriteState(status: CubitStatus.loading));

    final failureOrAuth = await favoriteUseCase.fetchFavorite();

    emit(
      failureOrAuth.fold(
        (l) => FavoriteState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => FavoriteState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }
}
