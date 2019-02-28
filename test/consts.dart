import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/models/user.dart';

const String TEST_ID = '1';
const String TEST_NAME = 'Test';
const int TEST_AMOUNT = 100;

final testSpeaker = Speaker(id: TEST_ID, name: TEST_NAME);
final testUser = User(id: TEST_ID, name: TEST_NAME);
final testSession = Session(id: TEST_ID, title: TEST_NAME);
final testTeam = Team(id: TEST_ID, title: TEST_NAME);
final testPartner = Partner(id: TEST_ID, title: TEST_NAME);
final testMember = Member(name: TEST_NAME, title: TEST_NAME);
final testLogo = Logo(name: TEST_NAME, logoUrl: TEST_NAME, linkUrl: TEST_NAME);
final testSchedule = Schedule(date: TEST_NAME, dateReadable: TEST_NAME);
final testTicket = Ticket(price: TEST_AMOUNT, name: TEST_NAME, currency: '\$',
    available: true, soldOut: false);