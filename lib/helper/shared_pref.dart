import 'package:riverpod_sample1/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String todoID = "/Todos";

class SharedPrefrence {
  SharedPrefrence._();

  static final SharedPrefrence _instance = SharedPrefrence._();

  static SharedPrefrence get instance => _instance;

  late SharedPreferences _prefs;

  void save(List<TodoModel> value) async {
    _prefs = await SharedPreferences.getInstance();
    List<String> todos = [];
    value.map((element) {
      todos.add(element.toJson());
    }).toList();

    _prefs.setStringList(todoID, todos);
  }

  Future<List<TodoModel>> getTodo() async {
    List<TodoModel> model = [];
    _prefs = await SharedPreferences.getInstance();
    final todos = _prefs.getStringList(todoID) ?? [];
    todos.map((element) => model.add(TodoModel.fromJson(element))).toList();
    return model;
  }
}
