import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/todoModel.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {Key? key,
      required this.title,
      required this.date,
      required this.onDelete})
      : super(key: key);
  final String title;
  final String date;
  final Function(String title) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Slidable(
        //Ação do arrastar o botão
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Deletar',
            onTap: () {
              onDelete(title);
            },
          ),
          IconSlideAction(
            color: Colors.teal,
            icon: Icons.edit,
            caption: 'Editar',
            onTap: () {},
          )
        ],
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: Colors.black26,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
