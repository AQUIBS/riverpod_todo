// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample1/providers/todo/todo_provider.dart';

Future openDeleteMenu(BuildContext context, int id) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Delete(id));
      });
}

class Delete extends ConsumerWidget {
  const Delete(this.id, {super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 150,
      width: 300,
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        children: [
          const Text(
            'Do you wish To Delete this Todo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                ontap: () {
                  Navigator.of(context).pop();
                },
                actionName: "Cancel",
              ),
              ActionButton(
                ontap: () {
                  ref.read(todoProvider.notifier).remove(id);
                  Navigator.of(context).pop();
                },
                actionName: "Remove",
              )
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback ontap;
  final String actionName;
  const ActionButton({
    Key? key,
    required this.ontap,
    required this.actionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8)),
        child: Text(
          actionName,
          style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 22,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
