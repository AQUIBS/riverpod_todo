import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample1/helper/dialogbox.dart';
import 'package:riverpod_sample1/helper/show_snackbar.dart';
import 'package:riverpod_sample1/models/todo_model.dart';
import 'package:riverpod_sample1/providers/todo/todo_provider.dart';

class TodoView extends ConsumerStatefulWidget {
  const TodoView({super.key});

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  @override
  void initState() {
    Future(() => ref.read(todoProvider.notifier).initialiseTodo());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'TODO',
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        actions: const [DeleteAllTodos()],
      ),
      body: ListView(
        children: [AddTodos(), const ShowTodos()],
      ),
    );
  }
}

class DeleteAllTodos extends ConsumerWidget {
  const DeleteAllTodos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        ref.read(todoProvider.notifier).removeALl();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.red.shade300,
        ),
      ),
    );
  }
}

class AddTodos extends ConsumerWidget {
  AddTodos({
    super.key,
  });

  final TextEditingController controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Type your Todos",
            focusColor: Colors.blueGrey.shade400,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              final todo = TodoModel(
                  id: Random().nextInt(999), desc: value, complete: false);

              ref.read(todoProvider.notifier).addTodo(todo);

              showSnackbar(context: context, snackBar: successSb);
              controller.text = "";
            }
          }),
    );
  }
}

class ShowTodos extends ConsumerWidget {
  const ShowTodos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider);
    return Container(
      height: 550,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
          itemCount: todo.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 20),
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                onLongPress: () {
                  openDeleteMenu(context, todo[index].id);
                },
                child: ListTile(
                  title: Text(
                    todo[index].desc,
                    style: todo[index].complete
                        ? const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red)
                        : const TextStyle(
                            fontSize: 18, color: Color(0xFF151515)),
                  ),
                  trailing: Checkbox(
                    value: todo[index].complete,
                    onChanged: (value) {
                      ref
                          .read(todoProvider.notifier)
                          .toggleTodo(todo[index].id, value!);
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
