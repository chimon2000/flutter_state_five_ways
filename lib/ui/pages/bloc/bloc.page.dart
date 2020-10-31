import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_five_ways/states/notes.state.dart';
import 'package:flutter_state_five_ways/extensions/extensions.dart';
import 'package:flutter_state_five_ways/ui/widgets/note.dart';

class BlocPage extends StatefulWidget {
  const BlocPage({Key key}) : super(key: key);

  @override
  _BlocPageState createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
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
    return BlocProvider(
      create: (BuildContext context) => NotesCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('My notes app')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FlatButton(
                  onPressed: () {
                    context.bloc<NotesCubit>().addNote();
                    _controller.clear();
                  },
                  child: Text('Create Note')),
              TextField(
                controller: _controller,
                onChanged: (value) =>
                    context.bloc<NotesCubit>().updateInput(value),
                decoration: InputDecoration.collapsed(hintText: 'Add a note'),
              ),
              Divider(),
              BlocBuilder(
                builder: (context, state) => Expanded(
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
      ),
    );
  }
}

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesState.initial());
  void addNote() {
    emit(state.copyWith(notes: state.notes.concat(state.input), input: ''));
  }

  void updateInput(String input) => emit(state.copyWith(input: input));
}
