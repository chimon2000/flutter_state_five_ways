import 'package:flutter/material.dart';
import 'package:flutter_state_five_ways/ui/routes.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: navigateTo(context, Routes.riverpod),
                child: Text('riverpod example'.toUpperCase()),
              ),
              FlatButton(
                onPressed: navigateTo(context, Routes.binder),
                child: Text('binder example'.toUpperCase()),
              ),
              FlatButton(
                onPressed: navigateTo(context, Routes.flutterCommand),
                child: Text('flutter_command example'.toUpperCase()),
              ),
              FlatButton(
                onPressed: navigateTo(context, Routes.mobx),
                child: Text('MobX example'.toUpperCase()),
              ),
              FlatButton(
                onPressed: navigateTo(context, Routes.bloc),
                child: Text('Bloc example'.toUpperCase()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Function() navigateTo(BuildContext context, String route) => () {
        return Navigator.of(context).pushNamed(route);
      };
}
