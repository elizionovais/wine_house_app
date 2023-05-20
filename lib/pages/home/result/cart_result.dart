import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_result.freezed.dart';

@freezed
abstract class CartResult<T> with _$CartResult<T> {
  const factory CartResult.success(T data) = Success;
  const factory CartResult.failure(String mensage) = Failure;
}