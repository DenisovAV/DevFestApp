import 'package:devfest_flutter_app/src/bloc/home/home_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/home/home_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/home/home_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/ui/widgets/home/home_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final TicketRepository ticketRepository;
  HomePage({Key key, @required this.ticketRepository})
      : assert(ticketRepository != null),
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _homeBloc;
  TicketRepository _ticketRepository;

  @override
  void initState() {
    _ticketRepository = widget.ticketRepository;
    _homeBloc = HomePageBloc(ticketRepository: _ticketRepository);
    _homeBloc.dispatch(HomePageInitiation());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      bloc: _homeBloc,
      child: BlocBuilder<HomePageEvent, HomePageState>(
        bloc: _homeBloc,
        builder: (BuildContext context, HomePageState state) {
          if (state is HomePageInit) {
            return LoadingWidget();
          }
          if (state is TicketChoosen) {
            return LoadingWidget();
          }
          if (state is HomePageDone) {
            return HomePageViewer(homePageBloc: _homeBloc);
          }
        },
      ),
    );
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}

