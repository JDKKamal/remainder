class Reminder {
  final List<dynamic> notificationIDs;
  final String title;
  final int dosage;
  final String remainderType;
  final int interval;
  final String startTime;

  Reminder({
    this.notificationIDs,
    this.title,
    this.dosage,
    this.remainderType,
    this.startTime,
    this.interval,
  });

  String get getName => title;
  int get getDosage => dosage;
  String get getType => remainderType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.notificationIDs,
      "name": this.title,
      "dosage": this.dosage,
      "type": this.remainderType,
      "interval": this.interval,
      "start": this.startTime,
    };
  }

  factory Reminder.fromJson(Map<String, dynamic> parsedJson) {
    return Reminder(
      notificationIDs: parsedJson['ids'],
      title: parsedJson['name'],
      dosage: parsedJson['dosage'],
      remainderType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}
