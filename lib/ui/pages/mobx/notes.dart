import 'package:mobx/mobx.dart';

part 'notes.g.dart';

class Notes = NotesBase with _$Notes;

abstract class NotesBase with Store {
  @observable
  String input = '';

  @observable
  ObservableList<String> notes = ObservableList();

  @action
  void updateInput(String val) {
    input = val;
  }

  @action
  void addNote() {
    notes.add(input);
    input = '';
  }
}
