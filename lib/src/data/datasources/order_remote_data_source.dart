import '../../common/api.dart';

abstract class OrderRemoteDataSource {


 // Future<OrderDetailEntity> fetchOrderDetail(PathParams params);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final API api;

  OrderRemoteDataSourceImpl(this.api);


  // @override
  // Future<OrderDetailEntity> fetchOrderDetail(PathParams params) async {
  //   try {
  //     final response = await api.dio.get(
  //       '${constants.host}orders/${params.path}/',
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return OrderDetailModel.fromJson(response.data);
  //     } else {
  //       throw ServerException();
  //     }
  //   } on DioException catch (e) {
  //     return api.handleDioException(e);
  //   }
  // }
}
