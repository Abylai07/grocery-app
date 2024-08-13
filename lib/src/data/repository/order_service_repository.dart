import '../../core/check_error_type.dart';
import '../../domain/repository/abstract_order_service_profile.dart';
import '../datasources/order_remote_data_source.dart';

class OrderServiceRepositoryImpl extends AbstractOrderServiceRepository {
  OrderServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final OrderRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  // @override
  // Future<Either<Failure, OrderDetailEntity>> fetchOrderDetail(params) {
  //   return _networkOperationHelper
  //       .performNetworkOperation(() => dataSource.fetchOrderDetail(params));
  // }
}
