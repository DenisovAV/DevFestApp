import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/consts/strings.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/common/expanded_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

//TODO: Сделать картинки из конфига (yml или по другому)
//TODO ExpandedWidget переделать для всех
//TODO Нажатия кнопок

class TicketsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandedWidget(
      image: AssetImage("assets/images/home.jpg"),
      child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(children: <Widget>[
            Center(child: _HeaderPlateWidget()),
            Container(height: 30.0),
            _TicketsPanel()
          ])),
    );
  }
}

class _TicketsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Ticket> tickets = BlocProvider.of(context).data.tickets;
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(width: 1.0, color: Colors.white),
        ),
        height: 250.0,
        width: 290.0,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _TicketCard(tickets[index]),
                  childCount: tickets.length,
                ),
              ),
            ),
          ],
        ));
  }
}

class _HeaderPlateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: 216.0,
          height: 72.0,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          )),
      Text('Nizhny Novgorod. October 27, 2018',
          style: Utils.subHeaderTextStyle2()),
      Container(
        height: 10.0,
      ),
      Text('Be a hero. Be a GDG!', style: Utils.headerTextStyle(Colors.white)),
      Container(
        height: 10.0,
      ),
      OutlineButton(
        borderSide: BorderSide(color: Colors.white),
        child: Text('VIEW HIGHLIGHTS', style: TextStyle(color: Colors.white)),
        onPressed: () =>
            /* FlutterYoutube.playYoutubeVideoById(
                apiKey: YOUTUBE_API,
                videoId: YOUTUBE_KEY,
                autoPlay: true, //default falase
                fullScreen: false //default false
            )*/
            BlocProvider.of(context).data.events.add(HighlightsTappedEvent()),
      )
    ]);
  }
}

class _TicketCard extends StatelessWidget {
  _TicketCard(this.ticket) : assert(ticket != null);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Column(children: <Widget>[
          Container(
              width: 180.0,
              child: Column(children: <Widget>[
                Text(
                    this.ticket.name +
                        '   ' +
                        this.ticket.currency +
                        this.ticket.price.toString(),
                    style: Utils.subHeaderTextStyle2()),
                Text(this.ticket.starts + ' - ' + this.ticket.ends,
                    style: Utils.subHeaderTextStyle()),
                Text(this.ticket.info ?? '', style: Utils.regularTextStyle())
              ])),
          Container(
              width: 160.0,
              child: Center(
                  child: OutlineButton(
                borderSide: BorderSide(color: Colors.white),
                child: Text(ticket.getButtolLabel,
                    style: TextStyle(
                        color: ticket.isValid ? Colors.white : Colors.grey,
                        fontSize: 12.0)),
                onPressed: () => BlocProvider.of(context)
                    .data
                    .events
                    .add(TicketTappedEvent(ticket)),
              )))
        ]));
  }
}
