import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_grid.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class SpeakersPage extends StatelessWidget {
  final MainBloc bloc;
  SpeakersPage(this.bloc, {Key key})
      : assert(bloc != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: bloc.speakersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(SpeakersLoadedEvent());
            return LoadingWidget();
          } else {
            return SpeakersGridViewer(bloc);
          }
        }
    );
  }
}

