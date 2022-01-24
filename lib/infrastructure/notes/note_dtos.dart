import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'note_dtos.freezed.dart';
//4 json serializable
part 'note_dtos.g.dart';
@freezed
class NoteDto with _$NoteDto {
  static FieldValue defaultServerTimeStamp = FieldValue.serverTimestamp();

  //empty constructor, because of custom method usage
  const NoteDto._();

  const factory NoteDto({
    ///id will not contain id of document, so it is marked as ignore
    // ignore: invalid_annotation_target
       @JsonKey(ignore: true)  String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    ///used to sort todos by date.
     @ServerTimestampConverter() required FieldValue? serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.noteBody.getOrCrash(),
      color: note.noteColor.getOrCrash().value,
      todos: note.maxListSize3
          .getOrCrash()
          .map(
            (todoItem) => TodoItemDto.fromDomain(todoItem),
      )
          .asList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }


  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(id!),
      noteBody: NoteBody(body),
      noteColor: NoteColor(Color(color)),
      maxListSize3: ListMaxSize3(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    ///copyWith is for populate ID
    return NoteDto.fromJson(doc.data()! as Map<String, dynamic>).copyWith(id: doc.id);
  }
}
///convert DataTime to ServerTimestamp
class ServerTimestampConverter implements JsonConverter<FieldValue?, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue? fieldValue) => fieldValue!;
}


@freezed
class TodoItemDto with _$TodoItemDto {
  //empty constructor, because of custom method usage
  const TodoItemDto._();

  factory TodoItemDto({
    ///id of document
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  //construct DTO from domain layer entity
  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
        id: todoItem.id.getOrCrash(),
        name: todoItem.todoName.getOrCrash(),
        done: todoItem.done);
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      todoName: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}

