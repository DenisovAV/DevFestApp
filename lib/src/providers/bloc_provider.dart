import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:flutter/material.dart';

class BlocMProvider extends InheritedWidget {
  const BlocMProvider({Key key, Widget child, this.data, this.auth}) : super(key: key, child: child);
  final DataBloc data;
  final AuthBloc auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static BlocMProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BlocMProvider);
  }
}
