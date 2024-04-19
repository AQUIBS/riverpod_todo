import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample1/helper/shared_pref.dart';
import 'package:riverpod_sample1/models/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  @override
  List<TodoModel> build() {
    return [];
  }

  // * methods

  void addTodo(TodoModel model) async {
    state = [model, ...state];
    SharedPrefrence.instance.save(state);
  }

  void toggleTodo(int id, bool value) async {
    state = state.map((todo) {
      return todo.id == id ? todo.copyWith(complete: value) : todo;
    }).toList();
    SharedPrefrence.instance.save(state);
  }

  void remove(int id) async {
    state = state.where((todo) => todo.id != id).toList();
    SharedPrefrence.instance.save(state);
  }

  void initialiseTodo() async {
    state = await SharedPrefrence.instance.getTodo();
  }

  void removeALl() {
    state = [];
    SharedPrefrence.instance.save(state);
  }
}
