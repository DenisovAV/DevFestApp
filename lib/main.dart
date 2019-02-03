import 'package:bloc/bloc.dart';
import 'package:devfest_flutter_app/src/devfestapp.dart';
import 'package:flutter/material.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

