import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  final UserRepository userRepository;

  SignInPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInBloc _signInBloc;

  @override
  void initState() {
    _signInBloc = SignInBloc(userRepository: widget.userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => _onButtonPressed(GoogleSignInButtonPressed()),
          color: Colors.grey,
          child: Text('Sign In', style: TextStyle(color: Colors.white))),
    );

    final skipButton = FlatButton(
      child: Text('Skip', style: TextStyle(color: Colors.white)),
      onPressed: () => _onButtonPressed(AnonymousSignInButtonPressed()),
    );

    return BlocBuilder<SignInEvent, SignInState>(
        bloc: _signInBloc,
        builder: (
          BuildContext context,
          SignInState state,
        ) {
          if (state is SignInFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
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
        });
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onButtonPressed(SignInEvent event) {
    print('dispatcghed');
    print(event);
    _signInBloc.dispatch(event);
  }

  @override
  void dispose() {
    _signInBloc.dispose();
    super.dispose();
  }
}
