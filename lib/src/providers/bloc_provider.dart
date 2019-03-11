import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:flutter/material.dart';

class Provider {
  Provider({
    @required this.data,
    @required this.auth,
  });

  final DataBloc data;
  final AuthBloc auth;
}

class BlocProvider extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.data,
    @required this.auth,
  }) : super(key: key);

  final Widget child;
  final DataBloc data;
  final AuthBloc auth;

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static Provider of(BuildContext context) {
    _BlocProviderInherited provider = context
        .ancestorInheritedElementForWidgetOfExactType(_BlocProviderInherited)
        ?.widget;
    return Provider(data: provider?.data, auth: provider?.auth);
  }
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void dispose() {
    widget.data?.dispose();
    widget.auth?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(
      data: widget.data,
      auth: widget.auth,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.data,
    @required this.auth,
  }) : super(key: key, child: child);

  final DataBloc data;
  final AuthBloc auth;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
