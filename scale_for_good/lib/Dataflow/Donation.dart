class Donation{
  DateTime date;
  double weight;
  String donatedBy;
  String description;
  String email;
  bool sent;

  Donation(this.weight, this.donatedBy, [this.description, this.email]) {
    date = DateTime.now();
    sent = false;
  }
}
