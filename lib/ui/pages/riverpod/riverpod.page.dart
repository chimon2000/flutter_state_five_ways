import 'package:flutter/material.dart';
import 'package:flutter_state_five_ways/states/notes.state.dart';
import 'package:flutter_state_five_ways/ui/widgets/note.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_state_five_ways/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodPage extends StatefulWidget {
  const RiverpodPage({Key key}) : super(key: key);

  @override
  _RiverpodPageState createState() => _RiverpodPageState();
}

class _RiverpodPageState extends State<RiverpodPage> {
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
      appBar: AppBar(title: Text('My notes app: riverpod')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  context.read(notesProvider).addNote();
                  _controller.clear();
                },
                child: Text('Create Note')),
            TextField(
              controller: _controller,
              onChanged: (value) =>
                  context.read(notesProvider).updateInput(value),
              decoration: InputDecoration.collapsed(hintText: 'Add a note'),
            ),
            Divider(),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  var state = watch(notesProvider.state);

                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        Note(text: state.notes[index]),
                    itemCount: state.notes.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

final notesProvider = StateNotifierProvider((ref) => NotesController());

class NotesController extends StateNotifier<NotesState> {
  NotesController() : super(NotesState.initial());

  void addNote() {
    state = state.copyWith(notes: state.notes.concat(state.input), input: '');
  }

  void updateInput(String input) => state = state.copyWith(input: input);
}
