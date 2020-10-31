import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_state_five_ways/ui/pages/mobx/notes.dart';
import 'package:flutter_state_five_ways/ui/widgets/note.dart';

class MobxPage extends StatefulWidget {
  const MobxPage({Key key}) : super(key: key);

  @override
  _MobxPageState createState() => _MobxPageState();
}

class _MobxPageState extends State<MobxPage> {
  var _notesStore = Notes();
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
      appBar: AppBar(title: Text('My notes app')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  _notesStore.addNote();
                  _controller.clear();
                },
                child: Text('Create Note')),
            TextField(
              controller: _controller,
              onChanged: _notesStore.updateInput,
              decoration: InputDecoration.collapsed(hintText: 'Add a note'),
            ),
            Divider(),
            Observer(
              builder: (_) => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Note(text: _notesStore.notes[index]),
                  itemCount: _notesStore.notes.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
