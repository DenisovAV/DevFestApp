import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthBloc _auth;
  final _startAnimationDuration = Duration(milliseconds: 750);
  final _curve = Curves.elasticInOut;
  double _logoHPadding = 200;
  double _loginHPadding = 200;
  double _skipHPadding = 200;

  @override
  void initState() {
    _auth = BlocProvider.of(context).auth;
    _startAnimation();
    super.initState();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      _logoHPadding = 30;
      _loginHPadding = 40;
      _skipHPadding = 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = AnimatedContainer(
      curve: _curve,
      duration: _startAnimationDuration,
      padding: EdgeInsets.symmetric(horizontal: _logoHPadding),
      child: AnimatedLogo(),
    );

    final loginButton = AnimatedContainer(
      curve: _curve,
      duration: _startAnimationDuration,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: _loginHPadding),
      child: MaterialButton(
          minWidth: 100.0,
          height: 42.0,
          onPressed: () => _auth.events.add(SignInGoogleEvent()),
          color: Colors.blue[400],
          child: Text('Sign In', style: TextStyle(color: Colors.white))),
    );

    final skipButton = AnimatedContainer(
      curve: _curve,
      duration: _startAnimationDuration,
      padding: EdgeInsets.symmetric(horizontal: _skipHPadding),
      child: MaterialButton(
        color: Colors.blueGrey[400],
        onPressed: () => _auth.events.add(SignInAnonimousEvent()),
        child: Text('Skip', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 150.0),
              loginButton,
              skipButton
            ]),
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {

  final _duration = Duration(seconds: 2, milliseconds: 500);
  double _horizontalPadding = 60;

  // make logo bigger
  void _increase() async {
    setState(() {});
    _horizontalPadding = 0;
    await Future.delayed(_duration);
    _reduce();
  }

  // make logo lower
  void _reduce() async {
    setState(() {});
    _horizontalPadding = 60;
    await Future.delayed(_duration);
    _increase();
  }

  @override
  void initState() {
    _increase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Image.asset('assets/images/logo_grey.png',),
      height: 100,
    );
  }
}
