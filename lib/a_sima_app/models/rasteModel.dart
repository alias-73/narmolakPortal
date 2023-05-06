class RasteModel {
  late String user_id;
  late String name;
  late String id;
  late String title;
  late String due_on;
  late String status;

  RasteModel.fromJson(Map < String , dynamic> parsedJson) {
    user_id = parsedJson['user_id'];
    id = parsedJson['id'];
    title = parsedJson['title'];
    due_on = parsedJson['due_on'];
    status = parsedJson['status'];
  }

}