
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/resources/schedule_repository.dart';
import 'package:devfest_flutter_app/src/resources/ticket_repository.dart';
import 'package:devfest_flutter_app/src/ui/screens/home/home_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/schedule/schedule_page.dart';
import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/speaker_repository.dart';
import 'package:devfest_flutter_app/src/ui/screens/speakers/speakers_page.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget widget,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _color = color,
        _title = title,
        _widget = widget,
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _widget;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: Semantics(
          label: 'Placeholder for $_title tab',
          child: _widget,
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({this.user});

  final User user;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: Icon(Icons.home),
        widget: HomePage(ticketRepository: FirestoreTicketRepository(Firestore.instance)),
        title: 'Home',
        color: Colors.blue,
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.schedule),
        widget: SchedulePage(scheduleRepository: FirestoreScheduleRepository(Firestore.instance),),
        title: 'Schedule',
        color: Colors.blue,
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.group),
        widget: SpeakersPage(speakerRepository: FirestoreSpeakerRepository(Firestore.instance)),
        title: 'Speakers',
        color: Colors.blue,
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.info),
        widget: LoadingWidget(),
        title: 'Partners',
        color: Colors.blue,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map((navigationView) => navigationView.item).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: IconHelper().getTitleLogo(120.0, 48.0),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              FirebaseAuth.instance.signOut();
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    value: 'Log out',
                    child: Text('Log out'),
                  )
                ],
          )
        ],
      ),
      body: Center(child: _buildTransitionsStack()),
      bottomNavigationBar: botNavBar,
    );
  }
}
