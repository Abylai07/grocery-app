import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/card_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/category_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/address_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/cards_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/usecase/product/product_usecase.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit(this._useCase) : super(const CardsState());

  final CardsUseCase _useCase;

  void fetchMyCards() async {
    emit(const CardsState(status: CubitStatus.loading));

    final failureOrAuth = await _useCase.fetchMyCards();

    emit(
      failureOrAuth.fold(
        (l) => CardsState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => CardsState(
          status: CubitStatus.success,
          selectCard: r.isNotEmpty ? r.first : null,
          entity: r,
        ),
      ),
    );
  }

  void deleteCard(int? addressId) async {
    emit(const CardsState(status: CubitStatus.loading));

    final failureOrAuth = await _useCase.deleteCard(PathParams(addressId.toString()));

    emit(
      failureOrAuth.fold(
            (l) => CardsState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => const CardsState(
          status: CubitStatus.success,
        ),
      ),
    );
  }

  checkMyCards(){
    if(!state.status.isSuccess){
      fetchMyCards();
    }
  }

  selectCard(CardEntity? card) {
    emit(state.copyWith(selectCard: card, paymentType: PaymentType.card));
  }

  selectPaymentType(PaymentType? type) {
    emit(state.copyWith(paymentType: type));
  }
}
