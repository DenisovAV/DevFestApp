import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc auth = BlocMProvider.of(context).auth;
    final logo = Hero(
      tag: 'hero-logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 36.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
          minWidth: 100.0,
          height: 42.0,
          onPressed: () => auth.events.add(SignInGoogleEvent()),
          color: Colors.grey,
          child: Text('Sign In', style: TextStyle(color: Colors.white))),
    );

    final skipButton = FlatButton(
      child: Text('Skip', style: TextStyle(color: Colors.white)),
      onPressed: () => auth.events.add(SignInAnonimousEvent()),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              loginButton,
              skipButton
            ]),
      ),
    );
  }
}
