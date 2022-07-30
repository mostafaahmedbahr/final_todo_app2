import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
 import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app_usin_firebase_work_shop2_group103/bloc/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var noteTitleCon  ;
  var noteCon ;
   var imgUrl;

  int randomColor()
  {
    return Random().nextInt(colorList.length);
  }
        List<Color> colorList = [
     Colors.red.shade100,
     Colors.green.shade100,
     Colors.yellowAccent.shade100,
     Colors.deepOrange.shade100,
     Colors.blue.shade100,
     Colors.teal.shade100,
     Colors.cyanAccent.shade100,
     Colors.redAccent.shade100,
   ];

  File? file;
  Reference? ref;
  var imagePicker = ImagePicker();
uploadImageToFirebase()async
{
  formKey.currentState?.save();
  emit(LoadingUploadImage());
  // await ref?.putFile(file);
  var imgPicked = await imagePicker.pickImage(source: ImageSource.camera);
  if(imgPicked != null)
  {
    file = File(imgPicked.path);
    var name = basename(imgPicked.path);
    print(imgPicked.path);
    print("*******************");
    print(name);
    var imgStorage = FirebaseStorage.instance.ref("images/$name");
    await imgStorage.putFile(file!);
    var imgUrl = await imgStorage.getDownloadURL();
    print("imgeurl : $imgUrl");
  }
  else
  {
    print("please choose image");
  }
 }

   var noteRef = FirebaseFirestore.instance.collection("notes");
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
     addNoteToFirebase() async
  {
    formKey.currentState?.save();
    emit(LoadingAddNote());
    await noteRef.add({
      "note name" : noteTitleCon.toString(),
      "note" :  noteCon.toString(),
     "imageUrl" : imgUrl.toString(),

    }).then((value)
   {
     print(noteTitleCon);
     emit(SuccessAddNote());
   }).catchError((error)
   {
     print("error ${error.toString()}");
     emit(ErrorAddNote());
   });
  }

  editNote(id)async
  {
   formKey.currentState!.save();
   emit(LoadingEditNote());
   await noteRef.doc(id).update({
     "note name" : noteTitleCon.toString(),
     "note" :  noteCon.toString(),
   }).then((value)
   {
     emit(SuccessEditNote());
   }).catchError((error)
   {
     print("errror ${error.toString()}");
     emit(ErrorEditNote());
   });
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imageName = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child(imageName);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(1000000);
                      var imageName = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child(imageName);
                      Navigator.of(context).pop();
                      // ألسطر ده لازم يتحط لما اضبف note لان كدا هيرفع الصورة حتى لو عملت باك
                      // await ref!.putFile(file!);
                      // imageurl = ref!.getDownloadURL();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),

          );

        });
  }
}

