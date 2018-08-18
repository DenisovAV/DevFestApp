
class Ticket {
  Ticket({
    this.available,
    this.name,
    this.soldOut,
    this.price,
    this.currency,
    this.starts,
    this.ends,
    this.info,
  });

  final bool available;
  final bool soldOut;
  final String name;
  final String info;
  final String price;
  final String starts;
  final String ends;
  final String currency;

  Ticket.fromMap(Map<dynamic, dynamic> data)
      : this(available: data['available'], name: data['name'], soldOut: data['soldOut'], price: data['price'], info: data['info'],
      currency: data['currency'], starts: data['starts'], ends: data['ends']);
}
