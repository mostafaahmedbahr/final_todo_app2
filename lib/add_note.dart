import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/cubit.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/states.dart';
class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            centerTitle: true,
            title: const Text("Add Note"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key:cubit.formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (v){
                      cubit.noteTitleCon = v ;
                    },
                    keyboardType: TextInputType.name,
                    maxLength: 30,
                    validator: (val) {
                      if (val!.length > 30) {
                        return "Title can't to be larger than 30 letter";
                      }
                      if (val.length < 2) {
                        return "Title can't to be less than 2 letter";
                      }
                      return null;
                    },
                    decoration:   InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      hintText: "Note Title",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border:   OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.note,
                      color: Colors.white,),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                     onSaved: (val)
                    {
                      cubit.noteCon=val;
                    },
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.length > 255) {
                        return "Title can't to be larger than 30 letter";
                      }
                      if (val.length < 2) {
                        return "Title can't to be less than 2 letter";
                      }
                      return null;
                    },

                    minLines: 1,
                    maxLines: 3,
                    maxLength: 300,
                    decoration:   InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                       hintText: "Note ",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border:   OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.note,
                      color: Colors.white,),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[900],
                    ),
                    onPressed: () async {
                     await cubit.addNoteToFirebase();
                    Navigator.pop(context);
                    },
                    child: const Text(
                      "Add Note",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
