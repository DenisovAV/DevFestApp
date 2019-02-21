import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:flutter/material.dart';

typedef void TicketItemTapCallback(Ticket ticket);

class TicketItem extends StatelessWidget {
  TicketItem(this.ticket, { @required this.onBannerTap})
      : assert(ticket != null && onBannerTap != null);

  final Ticket ticket;

  final TicketItemTapCallback onBannerTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(children: <Widget>[
          Container(
              width: 160.0,
              child: Column(children: <Widget>[
                Text(
                    this.ticket.name +
                        '   ' +
                        this.ticket.currency +
                        this.ticket.price.toString(),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text(this.ticket.starts + ' - ' + this.ticket.ends,
                    style: TextStyle(fontSize: 12.0)),
                Text(this.ticket.info ?? '', style: TextStyle(fontSize: 12.0))
              ])),
          Container(
              width: 160.0,
              child: Center(
                  child: OutlineButton(
                child: Text(this.ticket.getButtolLabel,
                    style: TextStyle(
                        color: ticket.isValid ? Colors.black : Colors.grey,
                        fontSize: 12.0)),
                onPressed: () {
                  this.ticket.isValid
                      ? Navigator.pop(context, this.ticket)
                      : null;
                },
              )))
        ]));
  }
}

class HomePageViewer extends StatefulWidget {
  final MainBloc bloc;

  @override
  _HomePageViewerState createState() => _HomePageViewerState();

  HomePageViewer(this.bloc, {Key key})
      : assert(bloc != null),
        super(key: key);
}

class _HomePageViewerState extends State<HomePageViewer>
    with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
  }

  void showTicketsDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('You selected: $value')));
        widget.bloc.events.add(TicketTappedEvent(value as Ticket));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: theme.platform,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/home.jpg"),
              fit: BoxFit.cover,
            )),
            child: Stack(fit: StackFit.expand, children: <Widget>[
              // This gradient ensures that the toolbar icons are distinct
              // against the background image.
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, -0.4),
                    colors: <Color>[Color(0x90000000), Color(0x00000000)],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 130.0),
                  child: Column(children: <Widget>[
                    SizedBox(
                        width: 216.0,
                        height: 72.0,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Center(
                            child: Text('Nizhny Novgorod. October 27, 2018',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)))),
                    Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 16.0),
                        child: Center(
                            child: Text('Be a hero. Be a GDG!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)))),
                    Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
                        child: Center(
                            child: OutlineButton(
                          child: Text('VIEW HIGHLIGHTS',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () =>
                              widget.bloc.events.add(HighlightsTappedEvent()),
                        ))),
                    Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
                        child: Center(
                            child: OutlineButton(
                          child: Text('BUY TICKETS',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            showTicketsDialog<Ticket>(
                                context: context,
                                child: SimpleDialog(
                                    title: Text('Choose your ticket'),
                                    children: widget.bloc.tickets
                                        .map(
                                          (ticket) => TicketItem(
                                              ticket,
                                              onBannerTap: (ticket) => widget
                                                  .bloc
                                                  .events
                                                  .add(TicketTappedEvent(ticket))),
                                        )
                                        .toList()));
                          },
                        )))
                  ]))
            ])),
      ),
    );
  }
}
