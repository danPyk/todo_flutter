// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NoteTearOff {
  const _$NoteTearOff();

  _Note call(
      {required UniqueId id,
      required NoteBody noteBody,
      required NoteColor noteColor,
      required ListMaxSize3<TodoItem> maxListSize3}) {
    return _Note(
      id: id,
      noteBody: noteBody,
      noteColor: noteColor,
      maxListSize3: maxListSize3,
    );
  }
}

/// @nodoc
const $Note = _$NoteTearOff();

/// @nodoc
mixin _$Note {
  UniqueId get id => throw _privateConstructorUsedError;
  NoteBody get noteBody => throw _privateConstructorUsedError;
  NoteColor get noteColor => throw _privateConstructorUsedError;
  ListMaxSize3<TodoItem> get maxListSize3 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res>;
  $Res call(
      {UniqueId id,
      NoteBody noteBody,
      NoteColor noteColor,
      ListMaxSize3<TodoItem> maxListSize3});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res> implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  final Note _value;
  // ignore: unused_field
  final $Res Function(Note) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? noteBody = freezed,
    Object? noteColor = freezed,
    Object? maxListSize3 = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
      noteBody: noteBody == freezed
          ? _value.noteBody
          : noteBody // ignore: cast_nullable_to_non_nullable
              as NoteBody,
      noteColor: noteColor == freezed
          ? _value.noteColor
          : noteColor // ignore: cast_nullable_to_non_nullable
              as NoteColor,
      maxListSize3: maxListSize3 == freezed
          ? _value.maxListSize3
          : maxListSize3 // ignore: cast_nullable_to_non_nullable
              as ListMaxSize3<TodoItem>,
    ));
  }
}

/// @nodoc
abstract class _$NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$NoteCopyWith(_Note value, $Res Function(_Note) then) =
      __$NoteCopyWithImpl<$Res>;
  @override
  $Res call(
      {UniqueId id,
      NoteBody noteBody,
      NoteColor noteColor,
      ListMaxSize3<TodoItem> maxListSize3});
}

/// @nodoc
class __$NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res>
    implements _$NoteCopyWith<$Res> {
  __$NoteCopyWithImpl(_Note _value, $Res Function(_Note) _then)
      : super(_value, (v) => _then(v as _Note));

  @override
  _Note get _value => super._value as _Note;

  @override
  $Res call({
    Object? id = freezed,
    Object? noteBody = freezed,
    Object? noteColor = freezed,
    Object? maxListSize3 = freezed,
  }) {
    return _then(_Note(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
      noteBody: noteBody == freezed
          ? _value.noteBody
          : noteBody // ignore: cast_nullable_to_non_nullable
              as NoteBody,
      noteColor: noteColor == freezed
          ? _value.noteColor
          : noteColor // ignore: cast_nullable_to_non_nullable
              as NoteColor,
      maxListSize3: maxListSize3 == freezed
          ? _value.maxListSize3
          : maxListSize3 // ignore: cast_nullable_to_non_nullable
              as ListMaxSize3<TodoItem>,
    ));
  }
}

/// @nodoc

class _$_Note extends _Note {
  const _$_Note(
      {required this.id,
      required this.noteBody,
      required this.noteColor,
      required this.maxListSize3})
      : super._();

  @override
  final UniqueId id;
  @override
  final NoteBody noteBody;
  @override
  final NoteColor noteColor;
  @override
  final ListMaxSize3<TodoItem> maxListSize3;

  @override
  String toString() {
    return 'Note(id: $id, noteBody: $noteBody, noteColor: $noteColor, maxListSize3: $maxListSize3)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Note &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.noteBody, noteBody) &&
            const DeepCollectionEquality().equals(other.noteColor, noteColor) &&
            const DeepCollectionEquality()
                .equals(other.maxListSize3, maxListSize3));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(noteBody),
      const DeepCollectionEquality().hash(noteColor),
      const DeepCollectionEquality().hash(maxListSize3));

  @JsonKey(ignore: true)
  @override
  _$NoteCopyWith<_Note> get copyWith =>
      __$NoteCopyWithImpl<_Note>(this, _$identity);
}

abstract class _Note extends Note {
  const factory _Note(
      {required UniqueId id,
      required NoteBody noteBody,
      required NoteColor noteColor,
      required ListMaxSize3<TodoItem> maxListSize3}) = _$_Note;
  const _Note._() : super._();

  @override
  UniqueId get id;
  @override
  NoteBody get noteBody;
  @override
  NoteColor get noteColor;
  @override
  ListMaxSize3<TodoItem> get maxListSize3;
  @override
  @JsonKey(ignore: true)
  _$NoteCopyWith<_Note> get copyWith => throw _privateConstructorUsedError;
}
