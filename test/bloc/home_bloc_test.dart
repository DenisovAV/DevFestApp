import 'package:devfest_flutter_app/src/bloc/home/home_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/home/home_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/home/home_bloc_state.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speaker_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTicketRepository extends Mock implements TicketRepository{}

void main() {
  HomePageBloc homeBloc;
  MockTicketRepository ticketRepository;

  setUp(() {
    ticketRepository = MockTicketRepository();
    homeBloc = HomePageBloc(ticketRepository: ticketRepository);
  });

  test('initial state is correct', () {
    expect(homeBloc.initialState, HomePageInit());
  });

  test('dispose does not emit new states', () {
    expectLater(
      homeBloc.state,
      emitsInOrder([]),
    );
    homeBloc.dispose();
  });

  group('HomePageLoaded', () {
    test('emits [init, loaded] for loading home page', () {
      final List<Ticket> tickets = [Ticket(name: 'Test', available: true, soldOut: false)];
      final expectedResponse = [
        HomePageInit(),
        HomePageDone()
      ];

      when(ticketRepository.getTickets()).thenAnswer((_) => Future.value(tickets).asStream());

      expectLater(
        homeBloc.state,
        emitsInOrder(expectedResponse),
      );

      homeBloc.dispatch(HomePageLoaded());
    });
  });
}
