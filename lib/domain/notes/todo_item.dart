import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/failures.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'todo_item.freezed.dart';


@freezed
class TodoItem with _$TodoItem {
  ///empty constructor is needed for custom getter
  const TodoItem._();

  const factory TodoItem({
    required UniqueId id,
    required TodoName todoName,
    required bool  done,
   }) = _TodoItem;

//todo might, but rather not

  factory TodoItem.empty() =>
      TodoItem(
          id: UniqueId(),
          todoName: TodoName(''),
          done: false ,
      );
/// retrieve value from TodoName
  Option<ValueFailure<dynamic>> get failureOption{
    return todoName.value.fold((l) => some(l), (r) => none());
  }


}
