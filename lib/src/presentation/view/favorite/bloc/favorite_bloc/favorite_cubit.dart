import 'package:grocery_app/src/domain/usecase/user/favorite_usecase.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/entity/product/product_entity.dart';
import '../../../../../domain/usecase/product/product_usecase.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteUseCase) : super(const FavoriteState());

  final FavoriteUseCase favoriteUseCase;

  void storeOrDeleteFavorite(bool isDelete, ProductEntity product) async {
    isDelete
        ? favoriteUseCase.deleteFavorite(PathParams(product.id.toString()))
        : favoriteUseCase.storeFavorite(MapParams({"product_id": product.id}));

    List<ProductEntity> newList = List<ProductEntity>.from(state.entity ?? []);

    if (isDelete) {
      newList.removeWhere((item) => item.id == product.id);
    } else {
      newList.add(product);
    }
    emit(state.copyWith(entity: newList));
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

  int checkCount = 0;
  void checkFavorites() async {
    if(state.entity != null && state.entity!.isNotEmpty){
      return;
    } else if(checkCount < 2){
      checkCount++;
      fetchFavorites();
    }
  }

  setInitState(){
    emit(const FavoriteState());
  }
}
