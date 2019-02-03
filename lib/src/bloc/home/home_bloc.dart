import 'package:devfest_flutter_app/src/bloc/home/home_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/home/home_bloc_state.dart';
import 'package:devfest_flutter_app/src/consts/strings.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final TicketRepository ticketRepository;
  List<Ticket> _tickets;

  HomePageBloc({
    @required this.ticketRepository,
  }) : assert(ticketRepository != null) {
    ticketRepository.getTickets().listen((tickets) {
      this._tickets = tickets;
      this.dispatch(HomePageLoaded());
    });
  }

  List<Ticket> get tickets => _tickets;

  HomePageState get initialState => HomePageInit();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageState currentState,
    HomePageEvent event,
  ) async* {
    if (event is HighlightsTapped) {
      yield HighlightsChoosen();
      await FlutterYoutube.playYoutubeVideoById(
        apiKey: YOUTUBE_API,
        videoId: YOUTUBE_KEY,
        autoPlay: true,
      );
      yield HomePageDone();
    }
    if (event is TicketTapped) {
      yield TicketChoosen();
      await _launchURL(event.ticket.url);
      yield HomePageDone();
    }
    if (event is HomePageLoaded) {
      yield HomePageDone();
    }
  }


  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

}
