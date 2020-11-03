import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_state_five_ways/states/notes.state.dart';
import 'package:flutter_state_five_ways/extensions/extensions.dart';
import 'package:flutter_state_five_ways/ui/widgets/note.dart';

class FlutterCommandPage extends StatefulWidget {
  const FlutterCommandPage({Key key}) : super(key: key);

  @override
  _FlutterCommandPageState createState() => _FlutterCommandPageState();
}

class _FlutterCommandPageState extends State<FlutterCommandPage> {
  final _notesViewModel = NotesViewModel();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My notes app: flutter command')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  _notesViewModel.updateNotesCommand
                      .execute(_notesViewModel.inputChangedCommand.value);
                  _controller.clear();
                },
                child: Text('Create Note')),
            TextField(
              controller: _controller,
              onChanged: _notesViewModel.inputChangedCommand,
              decoration: InputDecoration.collapsed(hintText: 'Add a note'),
            ),
            Divider(),
            ValueListenableBuilder<NotesState>(
              valueListenable: _notesViewModel.updateNotesCommand,
              builder: (context, state, _) => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Note(text: state.notes[index]),
                  itemCount: state.notes.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotesViewModel {
  NotesState state = NotesState.initial();

  Command<String, String> inputChangedCommand;
  Command<String, NotesState> updateNotesCommand;

  NotesViewModel() {
    inputChangedCommand = Command.createSync((x) => x, '');
    updateNotesCommand = Command.createSync((input) {
      state = state.copyWith(notes: state.notes.concat(input));
      inputChangedCommand.execute('');

      return state;
    }, NotesState.initial());
  }
}
