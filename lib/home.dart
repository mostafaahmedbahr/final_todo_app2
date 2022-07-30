 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/cubit.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/states.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/edit_note.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/widgets/note)card.dart';

import 'add_note.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            title: const Text("Todo App"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your recent Notes",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                ),),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                   stream: cubit.noteRef.snapshots(),
                    builder:(context,AsyncSnapshot<QuerySnapshot> snapShot){
                      if(snapShot.connectionState== ConnectionState.waiting)
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapShot.hasData)
                      {
                        return GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                            ),
                          children: snapShot.data!.docs.map((note)
                          {
                            return NoteCard(
                              onTap:(){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                {
                                  return EditNote(
                                    listNotes: note,
                                    docId: note.id,
                                  );
                                }));
                              },
                              doc: note,
                              color:cubit.colorList[cubit.randomColor()],
                            );
                          }).toList(),
                        );
                      }
                      return const Text("there is no Notes");
                    },

                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.indigo[900],
            label: const Text("Add Note"),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)
              {
                return   AddNote();
              }));
            },
            icon: const Icon(Icons.add,),
          ),
        );
      },

    );
  }
}
