import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/ui/widgets/home/home_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  final MainBloc bloc;
  HomePage(this.bloc, {Key key})
      : assert(bloc != null),
        super(key: key);

  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: bloc.ticketsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(TicketsLoadedEvent());
            return LoadingWidget();
          } else {
            return HomePageViewer(bloc);
          }
        }
    );
  }
}


