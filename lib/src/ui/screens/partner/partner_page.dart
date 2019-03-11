import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/partners_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class PartnerPage extends StatelessWidget {
  PartnerPage({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    return StreamBuilder<BlocEvent>(
        stream: bloc.teamsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(TeamLoadedEvent());
            return LoadingWidget();
          } else {
            return PartnersWidget(bloc.partners);
          }
        }
    );
  }
}




