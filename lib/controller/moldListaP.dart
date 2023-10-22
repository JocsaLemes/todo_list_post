import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_post/controller/listaP.dart';

class ListaPadrao extends StatelessWidget {
  const ListaPadrao({
    super.key,
    required this.listas,
    required this.onDelete,
  });

  final Listas listas;
  final Function(Listas) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.50,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (value) {
              onDelete(listas);
              print("deletar");
            },
            icon: Icons.delete,
            backgroundColor: const Color.fromARGB(158, 244, 67, 54),
            label: "Deletar",
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(47, 77, 255, 0),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          listas.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    DateFormat("dd/MM/yyyy - HH:mm").format(listas.dateTime),
                    style: const TextStyle(
                        fontWeight: FontWeight.w100, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 9,
          )
        ],
      ),
    );
  }
}
