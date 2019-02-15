import 'package:devfest_flutter_app/src/bloc/speakers/speaker_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../consts.dart';

class MockSpeakerRepository extends Mock implements SpeakerRepository{}

void main() {
  SpeakerBloc speakerBloc;
  MockSpeakerRepository speakerRepository;

  setUp(() {
    speakerRepository = MockSpeakerRepository();
    final List<Speaker> speakers = [testSpeaker];
    when(speakerRepository.getSpeakers()).thenAnswer((_) => Future.value(speakers).asStream());
    speakerBloc = SpeakerBloc(speakerRepository: speakerRepository);

  });

  test('initial state is correct', () {
    expect(speakerBloc.initialState, SpeakersInit());
  });

  test('dispose does not emit new states', () {
    expectLater(
      speakerBloc.state,
      emitsInOrder([]),
    );
    speakerBloc.dispose();
  });

  group('SpeakersGridLoaded', () {
    test('emits [init, loaded] for loading speakers', () {
      final expectedResponse = [
        SpeakersInit(),
        SpeakersDone()
      ];

      expectLater(
        speakerBloc.state,
        emitsInOrder(expectedResponse),
      );

      speakerBloc.dispatch(SpeakersLoaded());
    });
  });

  group('SpeakerTapped', () {
    test('emits [init, loaded] after tapping', () {
      final expectedResponse = [
        SpeakersInit(),
        SpeakersDone()
      ];

      expectLater(
        speakerBloc.state,
        emitsInOrder(expectedResponse),
      );

      speakerBloc.dispatch(SpeakerFooterTapped(speaker: testSpeaker));
    });
  });
}
