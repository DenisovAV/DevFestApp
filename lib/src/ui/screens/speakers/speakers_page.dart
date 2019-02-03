import 'package:devfest_flutter_app/src/bloc/speakers/speaker_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_grid.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeakersPage extends StatefulWidget {
  final SpeakerRepository speakerRepository;
  SpeakersPage({Key key, @required this.speakerRepository})
      : assert(speakerRepository != null),
        super(key: key);

  @override
  _SpeakersPageState createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  SpeakerBloc _speakerBloc;
  SpeakerRepository _speakerRepository;

  @override
  void initState() {
    _speakerRepository = widget.speakerRepository;
    _speakerBloc = SpeakerBloc(speakerRepository: _speakerRepository);
    _speakerBloc.dispatch(SpeakersGridInitiation());
    super.initState();
  }

  @override
  void dispose() {
    _speakerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpeakerBloc>(
      bloc: _speakerBloc,
      child: BlocBuilder<SpeakersEvent, SpeakersState>(
        bloc: _speakerBloc,
        builder: (BuildContext context, SpeakersState state) {
          if (state is SpeakersInit || state is SpeakersLoading) {
            return LoadingWidget();
          }
          if (state is SpeakersDone) {
            return SpeakersGridViewer(speakerBloc: _speakerBloc,);
          }
        },
      ),
    );
  }
}

