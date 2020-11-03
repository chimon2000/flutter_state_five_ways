import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_five_ways/ui/pages/binder/binder.page.dart';
import 'package:flutter_state_five_ways/ui/pages/pages.dart';
import 'package:flutter_state_five_ways/ui/pages/root/root.page.dart';

class Routes {
  static String root = "/";
  static String bloc = "/bloc";
  static String riverpod = "/riverpod";
  static String mobx = "/mobx";
  static String binder = "/binder";
  static String flutterCommand = "/flutter-command";

  static void configureRoutes() {
    FluroRouter.appRouter.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");

      return Scaffold(body: Center());
    });

    for (MapEntry<String, Handler> e in routeHandlers.entries) {
      print(e.key);
      FluroRouter.appRouter.define(e.key,
          handler: e.value, transitionType: TransitionType.material);
    }
  }
}

Map<String, Handler> routeHandlers = {
  '${Routes.root}': Handler(handlerFunc: (BuildContext _, __) => RootPage()),
  '${Routes.binder}':
      Handler(handlerFunc: (BuildContext _, __) => BinderPage()),
  '${Routes.bloc}': Handler(
      handlerFunc: (BuildContext _, __) => BlocProvider<NotesCubit>(
          create: (_) => NotesCubit(), child: BlocPage())),
  '${Routes.flutterCommand}':
      Handler(handlerFunc: (BuildContext _, __) => FlutterCommandPage()),
  '${Routes.riverpod}':
      Handler(handlerFunc: (BuildContext _, __) => RiverpodPage()),
  '${Routes.mobx}': Handler(handlerFunc: (BuildContext _, __) => MobxPage()),
};
