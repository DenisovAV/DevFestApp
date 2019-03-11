import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/home/home_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key})
      : super(key: key);

  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    return StreamBuilder<BlocEvent>(
        stream: bloc.ticketsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(TicketsLoadedEvent());
            return LoadingWidget();
          } else {
            return HomePageViewer();
          }
        }
    );
  }
}


