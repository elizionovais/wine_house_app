import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_result.freezed.dart';

@freezed
abstract class OrdersResult<T> with _$OrdersResult<T> {
  const factory OrdersResult.success(T data) = Success;
  const factory OrdersResult.failure(String mensage) = Failure;
}