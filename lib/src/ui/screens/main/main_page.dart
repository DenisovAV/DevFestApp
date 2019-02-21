
import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/consts/strings.dart';
import 'package:devfest_flutter_app/src/ui/screens/home/home_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/schedule/schedule_page.dart';
import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/ui/screens/speakers/speakers_page.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/info_widget.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  NavigationItem({
    Widget icon,
    Widget widget,
    String title,
  })  : bodyItem = widget,
        barItem = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
          backgroundColor: Colors.blue,
        );
  final Widget bodyItem;
  final BottomNavigationBarItem barItem;

}

class MainPage extends StatefulWidget {
  MainPage(this.bloc, {this.user});

  final User user;
  final MainBloc bloc;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<NavigationItem> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationItem>[
      NavigationItem(
        icon: Icon(Icons.home),
        widget: HomePage(widget.bloc),
        title: HOME,
      ),
      NavigationItem(
        icon: Icon(Icons.schedule),
        widget: SchedulePage(widget.bloc),
        title: SCHEDULE,
      ),
      NavigationItem(
        icon: Icon(Icons.group),
        widget: SpeakersPage(widget.bloc),
        title: SPEAKERS,
      ),
      NavigationItem(
        icon: Icon(Icons.info),
        widget: InfoTabWidget(widget.bloc),
        title: INFO,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: widget.bloc.navigationStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            widget.bloc.initNavigation();
            return LoadingWidget();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: IconHelper().getTitleLogo(120.0, 48.0),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (String value)  => widget.bloc.logoutCall(),
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        value: SIGN_OUT,
                        child: Text(SIGN_OUT),
                      )
                    ],
                  )
                ],
              ),
              body: _navigationViews[(snapshot.data as NavigatorEvent).index].bodyItem,
              bottomNavigationBar: BottomNavigationBar(
                items: _navigationViews
                    .map((navigationView) => navigationView.barItem).toList(),
                currentIndex: (snapshot.data as NavigatorEvent).index,
                type: BottomNavigationBarType.shifting,
                onTap: (int index) {
                  widget.bloc.events.add(NavigatorEvent(index));
                },
              ),
            );
          }
        }
    );
  }
}
