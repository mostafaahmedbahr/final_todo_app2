import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/cubit.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/states.dart';

class NoteCard extends StatelessWidget {
  NoteCard(
      {required this.doc, required this.onTap, required this.color, Key? key})
      : super(key: key);
  QueryDocumentSnapshot? doc;
  Function()? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Dismissible(
          onDismissed: (direction) async {
            await cubit.noteRef.doc(doc?.id).delete();
          },
          key: UniqueKey(),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Column(
                children: [
                  Text(
                    "${doc!['note name']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${doc!['note']}",
                    style: TextStyle(height: 2, color: Colors.grey[800]),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
