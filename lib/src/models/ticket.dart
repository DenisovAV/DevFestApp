import 'package:devfest_flutter_app/src/consts/strings.dart';
import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  static String AVAILABLE = 'available';
  static String NAME = 'name';
  static String SOLD_OUT = 'soldOut';
  static String PRICE = 'price';
  static String CURRENCY = 'currency';
  static String STARTS = 'starts';
  static String ENDS = 'ends';
  static String INFO = 'info';
  static String URL = 'url';

  Ticket(
      {this.available,
      this.name,
      this.soldOut,
      this.price,
      this.currency,
      this.starts,
      this.ends,
      this.info,
      this.url})
      : assert(name != null),
        assert(soldOut != null),
        assert(available != null),
        super([
          available,
          name,
          soldOut,
          price,
          currency,
          starts,
          ends,
          info,
          url
        ]);

  final bool available;
  final bool soldOut;
  final String name;
  final String info;
  final int price;
  final String starts;
  final String ends;
  final String currency;
  final String url;

  bool get isValid => available && !soldOut;

  String get getButtolLabel => soldOut
      ? TICKETS_SOLD_OUT
      : (available ? TICKETS_BUY_TICKET : TICKETS_NOT_AVAILABLE);

  @override
  String toString() =>
      'Ticket {name: $name, price: $price, isValid: $isValid, currency: $currency, info: $info}';

  Ticket.fromMap(Map<dynamic, dynamic> data)
      : this(
            available: data[AVAILABLE],
            name: data[NAME],
            soldOut: data[SOLD_OUT],
            price: data[PRICE],
            info: data[INFO],
            currency: data[CURRENCY],
            starts: data[STARTS],
            ends: data[ENDS],
            url: data[URL]);

  Map<String, Object> toJson() => {
        AVAILABLE: available,
        NAME: name,
        SOLD_OUT: soldOut,
        PRICE: price,
        INFO: info,
        CURRENCY: currency,
        STARTS: starts,
        ENDS: ends,
        URL: url,
      };
}
