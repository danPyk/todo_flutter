import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_flutter/core/value_objects.dart';
import 'package:todo_flutter/domain/auth/auth_failure.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/domain/notes/value_objects.dart';

part 'note_dtos.freezed.dart';

//4 json serializable
part 'note_dtos.g.dart';


@freezed
class NoteDto with _$NoteDto {
  static  FieldValue defaultServerTimeStamp =  FieldValue.serverTimestamp();

  //empty constructor, because of custom method usage
  const NoteDto._();

  const factory NoteDto({
    ///id will not contain id of document, so it is marked as ignore
    //todo in orignial code this parameter is ommited by using json annotation
    required String id,
    required String body,
    required int color,
    required List<dynamic> todos,

    ///used to sort todos by date. Will be provided by firestore?
    //todo might be wrong
     @ServerTimestampConverter() required
        FieldValue? serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.noteBody.getOrCrash(),
      color: note.noteColor.getOrCrash().value,

      ///converts todos into TodoItemDto
      todos: note.maxListSize3
          .getOrCrash()
          .map(
            (todoItem) => TodoItemDto.fromDomain(todoItem),
          )
          .toList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
        id: UniqueId.fromString(id),
        noteBody: NoteBody(body),
        noteColor: NoteColor(Color(color)),
        //todo might
        maxListSize3: ListMaxSize3(
          todos.map((dto) => dto.toDomain()).toList() as List<TodoItem>,
        ));
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot documentSnapshot) {
    ///copyWith is for populate ID
    return NoteDto.fromJson(documentSnapshot.data()! as Map<String, dynamic>)
        .copyWith(id: documentSnapshot.id);
  }

  //todo not finished
  static Map<String, dynamic> convertObjectToJson(Object? object) => {
        'name': object,
        'age': object,
      };
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
      id: UniqueId.fromString(this.id),
      todoName: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}

///convert DataTIme to ServerTimestamp
class ServerTimestampConverter implements JsonConverter<FieldValue?, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue? fieldValue) => fieldValue!;
}
