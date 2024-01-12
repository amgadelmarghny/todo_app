class TaskModel {
  final String title;
  final String time;
  final String date;
  String? status;
  int? id;

  TaskModel(
      {required this.title,
      required this.time,
      required this.date,
      this.status,
      this.id});

  factory TaskModel.fromSQflite(dynamic data) {
    return TaskModel(
        title: data['title'],
        time: data['time'],
        date: data['date'],
        status: data['status'],
        id: data['id,']);
  }
}
