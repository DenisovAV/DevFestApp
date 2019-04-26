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
  double _devFestLogoHPadding = 250;
  double _gdgLogoHPadding = 200;
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
      _devFestLogoHPadding = 90;
      _gdgLogoHPadding = 30;
      _loginHPadding = 40;
      _skipHPadding = 60;
    });
  }

  @override
  Widget build(BuildContext context) {

    final devFestLogo = AnimatedContainer(
      duration: _startAnimationDuration,
      curve: _curve,
      padding: EdgeInsets.symmetric(horizontal: _devFestLogoHPadding),
      margin: EdgeInsets.only(top: 60),
      child: Image.asset("assets/images/logo_grey.png"),
    );

    final gdgLogo = AnimatedContainer(
      curve: _curve,
      height: 200,
      duration: _startAnimationDuration,
      padding: EdgeInsets.symmetric(horizontal: _gdgLogoHPadding),
      child: SplashAnimation()
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
              devFestLogo,
              gdgLogo,
              SizedBox(height: 100.0),
              loginButton,
              skipButton,
            ]),
      ),
    );
  }
}

class SplashAnimation extends StatefulWidget {
  @override
  _SplashAnimationState createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _logoController;
  Animation<double> _logoAnimation;

  @override
  void initState() {
    _logoController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _logoAnimation = CurvedAnimation(
      curve: Curves.linear,
      parent: _logoController,
    );
    _logoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) _logoController.reverse();
      if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    Future.delayed(Duration(seconds: 2)).then((_) => _logoController.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
      animation: _logoAnimation,
      child: Image.asset("assets/images/organizer-logo.png"),
    );
  }

  @override
  void dispose() {
    _logoController.stop();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  final _size = Tween(begin: 0.0, end: 60.0);
  AnimatedLogo({Animation<double> animation, this.child})
      : super(listenable: animation);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Container(
      padding: EdgeInsets.all(_size.evaluate(animation)),
      child: child,
    );
  }
}
