import 'package:bloc/bloc.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_event.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/resources/user_repository.dart';
import 'package:devfest_flutter_app/src/ui/screens/login/sign_in_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/login/splash_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/main/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyApp(),
    );
  }
}

//TODO - remove old code
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'DevFest Gorky 2018',
        theme: new ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            fontFamily: "GoogleSans"),
        home: AppPage(userRepository: FirebaseUserRepository(FirebaseAuth.instance, GoogleSignIn())),
        //navigatorObservers: <NavigatorObserver>[observer],
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) => MainPage(),
          '/LoginPage': (BuildContext context) => SignInPage(),
          '/AppPage': (BuildContext context) => AppPage(),
        });
  }
}

class AppPage extends StatefulWidget {
  final UserRepository userRepository;

  AppPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<AppPage> createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  AuthBloc _authenticationBloc;
  UserRepository _userRepository;

  @override
  void initState() {
    _userRepository = widget.userRepository;
    _authenticationBloc = AuthBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthEvent, AuthState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is AuthInit) {
              return SplashPage();
            }
            if (state is AuthLoggedIn) {
              return MainPage(user: state.user);
            }
            if (state is AuthLoggedOut) {
              return SignInPage(userRepository: _userRepository);
            }
          },
        ),
      ),
    );
  }
}
