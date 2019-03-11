import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_grid.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class SpeakersPage extends StatelessWidget {
  SpeakersPage({Key key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    return StreamBuilder<BlocEvent>(
        stream: bloc.speakersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(SpeakersLoadedEvent());
            return LoadingWidget();
          } else {
            return SpeakersGridViewer();
          }
        }
    );
  }
}

