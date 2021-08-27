class Date {
  late int day;
  late int month;
  late int year;

  Date(DateTime date) {
    this.day = date.day;
    this.month = date.month;
    this.year = date.year;
  }
  @override
  String toString() {
    return '$day-$month-$year';
  }
}
