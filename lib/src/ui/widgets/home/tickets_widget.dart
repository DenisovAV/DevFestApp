import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/common/expanded_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

//TODO: Сделать картинки и надписи из конфига (yml или по другому)

class TicketsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandedWidget(
        image: AssetImage("assets/images/home.jpg"),
        child: TransparentWidget(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0)
                        return Center(child: _HeaderPlateWidget());
                      if (index > 1) return _TicketsPanel();
                      return Container(height: 30.0);
                    },
                    childCount: 3,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _TicketsPanel extends StatelessWidget {
  _TicketsPanel();

  @override
  Widget build(BuildContext context) {
    List<Widget> tickets = _separate(BlocProvider.of(context).data.tickets)
        .map((list) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: list
                .map((ticket) => Expanded(child: _TicketCard(ticket)))
                .toList()))
        .toList();
    return TransparentWidget(
        height: 150.0 * ((tickets.length + 1) / 2).truncate() + 60.0,
        child: Column(children: [
          Container(height: 10.0),
          Text(
            'Tickets',
            style: Utils.getPreparedTextStyle(fontSize: Utils.header_size),
          ),
          Container(height: 10.0),
          ...tickets
        ]));
  }

  List<List<Ticket>> _separate(List<Ticket> tickets) {
    List<List<Ticket>> ret = List<List<Ticket>>();
    for (int i = 0; i < tickets.length; i += 2) {
      List<Ticket> tmp = List<Ticket>();
      tmp.add(tickets[i]);
      if (i + 1 != tickets.length) {
        tmp.add(tickets[i + 1]);
      }
      ret.add(tmp);
    }
    return ret;
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
          style: Utils.getPreparedTextStyle(fontSize: Utils.info_size)),
      Container(
        height: 10.0,
      ),
      Text('Be a hero. Be a GDG!',
          style: Utils.getPreparedTextStyle(fontSize: Utils.header_size)),
      Container(
        height: 10.0,
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
              'What is DevFest? Google Developer Group DevFests are the largest'
              ' Google related events in the world! Each DevFest is carefully'
              ' crafted for you by your local GDG community to bring in awesome'
              ' speakers from all over the world, great topics, and lots fun!',
              textAlign: TextAlign.center,
              style:
                  Utils.getPreparedTextStyle(fontSize: Utils.sub_header_size))),
      Container(
        height: 10.0,
      ),
      OutlineButton(
        borderSide: BorderSide(color: Colors.white),
        child: Text('VIEW HIGHLIGHTS', style: TextStyle(color: Colors.white)),
        onPressed: () =>
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
              width: 200.0,
              child: Column(children: <Widget>[
                Text(
                    this.ticket.name +
                        '  ' +
                        this.ticket.currency +
                        this.ticket.price.toString(),
                    style: Utils.getPreparedTextStyle(
                        fontSize: Utils.ticket_size)),
                Text(this.ticket.starts + ' - ' + this.ticket.ends,
                    style: Utils.getPreparedTextStyle(
                        fontSize: Utils.sub_header_size)),
                Text(this.ticket.info ?? '', style: Utils.getPreparedTextStyle())
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
