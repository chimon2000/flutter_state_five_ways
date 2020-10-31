import 'package:equatable/equatable.dart';

class NotesState extends Equatable {
  final List<String> notes;
  final String input;

  NotesState(
    this.notes,
    this.input,
  );

  @override
  List<Object> get props => [notes, input];

  @override
  bool get stringify => true;

  NotesState copyWith({
    List<String> notes,
    String input,
  }) {
    return NotesState(
      notes ?? this.notes,
      input ?? this.input,
    );
  }

  NotesState.initial()
      : notes = [],
        input = '';
}
