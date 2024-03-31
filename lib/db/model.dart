class DataModel {
  final String date;
  final double hours;

  DataModel({required this.date, required this.hours});

  Map<String, Object?> toMap() {
    return {"date": date, "hours": hours};
  }
}
