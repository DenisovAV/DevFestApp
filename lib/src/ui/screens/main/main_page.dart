import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/consts/strings.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/screens/home/home_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/schedule/schedule_page.dart';
import 'package:devfest_flutter_app/src/ui/screens/speakers/speakers_page.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/info_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        widget: HomePage(),
        title: HOME,
      ),
      NavigationItem(
        icon: Icon(Icons.schedule),
        widget: SchedulePage(),
        title: SCHEDULE,
      ),
      NavigationItem(
        icon: Icon(Icons.group),
        widget: SpeakersPage(),
        title: SPEAKERS,
      ),
      NavigationItem(
        icon: Icon(Icons.info),
        widget: InfoTabWidget(),
        title: INFO,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    final AuthBloc auth = BlocProvider.of(context).auth;
    return StreamBuilder<BlocEvent>(
        stream: bloc.navigationStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.initNavigation();
            return LoadingWidget();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: SizedBox(
                    width: 120.0,
                    height: 48.0,
                    child: SvgPicture.asset('assets/images/logo-monochrome.svg',
                        color: Colors.white)),
                actions: <Widget>[
                  if (auth.user.name != null)
                    Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleImage(
                            CachedNetworkImageProvider(auth.user.photoUrl),
                            size: 46.0)),
                  PopupMenuButton<String>(
                    onSelected: (String value) =>
                        auth.events.add(LogoutEvent()),
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
              body: _navigationViews[(snapshot.data as NavigatorEvent).index]
                  .bodyItem,
              bottomNavigationBar: BottomNavigationBar(
                items: _navigationViews
                    .map((navigationView) => navigationView.barItem)
                    .toList(),
                currentIndex: (snapshot.data as NavigatorEvent).index,
                type: BottomNavigationBarType.shifting,
                onTap: (int index) {
                  bloc.events.add(NavigatorEvent(index));
                },
              ),
            );
          }
        });
  }
}
