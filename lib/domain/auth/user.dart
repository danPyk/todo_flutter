//unique ID
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/value_objects.dart';

part 'user.freezed.dart';
//data class/entity which have miltiple ValueObjects
@freezed
 class User with _$User{
  const factory User(
     UniqueId id,
  ) = _User;
}


