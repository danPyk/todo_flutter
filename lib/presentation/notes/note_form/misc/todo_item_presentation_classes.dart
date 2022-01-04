import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'todo_item_presentation_classes.freezed.dart';

///very similar class to TodoItemDto, but here String is replaced by UniqueId

@freezed
class TodoItemPrimitive with _$TodoItemPrimitive{
  const TodoItemPrimitive._();
const factory TodoItemPrimitive(
  { required UniqueId id,
  required String name,
  required bool done,}

  ) = _TodoItemPrimitive;

factory TodoItemPrimitive.empty(){
  //todo might UniqueId be null
  return  TodoItemPrimitive(id: UniqueId(), name: '', done: false);
}

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) {
    return TodoItemPrimitive(
        id: todoItem.id,
        name: todoItem.todoName.getOrCrash(),
        done: todoItem.done);
  }

  TodoItem toDomain() {
    return TodoItem(
      id: id,
      todoName: TodoName(name),
      done: done,
    );
  }

}