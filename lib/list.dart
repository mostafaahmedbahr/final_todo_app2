// ListView.builder(
// physics: const BouncingScrollPhysics(),
// itemCount: snapShot.data.docs.length,
// itemBuilder: (context, index) {
// return Dismissible(
// onDismissed: (direction)async
// {
// await cubit.noteRef.doc(snapShot.data.docs[index].id).delete();
// },
// key:  UniqueKey(),
// child: ListTile(
// title:   Text("${snapShot.data.docs[index]['note name']}"),
// leading: Image.network("${snapShot.data.docs[index]['imageUrl']}"),
// subtitle:Text("${snapShot.data.docs[index]['note']}"),
// ),
// );
// })