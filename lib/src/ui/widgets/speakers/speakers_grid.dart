import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpeakersGridViewer extends StatelessWidget {

  SpeakersGridViewer({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocMProvider.of(context).data;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: EdgeInsets.all(4.0),
                childAspectRatio:
                (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: bloc.speakers
                    .map<SpeakerGridItem>((_speaker) => SpeakerGridItem(
                    _speaker,
                    onBannerTap: (tapped) {
                      bloc.events.add(SpeakersTappedEvent(tapped));
                    }))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpeakerGridItem extends StatelessWidget {
  SpeakerGridItem(this.speaker, {Key key, @required this.onBannerTap})
      : assert(speaker != null && speaker.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Speaker speaker;
  final SpeakerItemTapCallback onBannerTap;

  void openSpeakerDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SpeakerViewer(speaker)));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
        onTap: () {
          openSpeakerDetails(context);
        },
        child: Hero(
            key: Key(speaker.photoUrl),
            tag: speaker.tag,
            child: Image.network(
              speaker.photoUrl,
              fit: BoxFit.cover,
            )));

    final IconData icon = Icons.star_border;

    return GridTile(
      footer: GestureDetector(
        onTap: () => onBannerTap(speaker),
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: SpeakerTitleText(speaker.name),
          subtitle: SpeakerTitleText(speaker.company),
          trailing: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      child: image,
    );
  }
}
