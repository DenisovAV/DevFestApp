import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/partners_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class PartnerPage extends StatelessWidget {
  final MainBloc bloc;
  PartnerPage(this.bloc, {Key key})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: bloc.teamsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(TeamLoadedEvent());
            return LoadingWidget();
          } else {
            print(bloc.partners);
            return PartnersWidget(bloc.partners);
          }
        }
    );
  }
}




