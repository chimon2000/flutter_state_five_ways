import 'package:binder/binder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_five_ways/extensions/extensions.dart';
import 'package:flutter_state_five_ways/states/notes.state.dart';
import 'package:flutter_state_five_ways/ui/widgets/note.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({Key key}) : super(key: key);

  @override
  _BinderPageState createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> {
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
    final state = context.watch(notesRef);

    return Scaffold(
      appBar: AppBar(title: Text('My notes app: binder')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  context.use(notesViewLogicRef).addNote();
                  _controller.clear();
                },
                child: Text('Create Note')),
            TextField(
              controller: _controller,
              onChanged: (value) =>
                  context.use(notesViewLogicRef).updateInput(value),
              decoration: InputDecoration.collapsed(hintText: 'Add a note'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Note(text: state.notes[index]),
                itemCount: state.notes.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

final notesRef = StateRef(NotesState.initial());
final notesViewLogicRef = LogicRef((scope) => NotesViewLogic(scope));

class NotesViewLogic with Logic {
  const NotesViewLogic(this.scope);

  @override
  final Scope scope;

  void addNote() {
    var state = read(notesRef);
    write(notesRef,
        state.copyWith(notes: state.notes.concat(state.input), input: ''));
  }

  void updateInput(String input) =>
      write(notesRef, read(notesRef).copyWith(input: input));
}
