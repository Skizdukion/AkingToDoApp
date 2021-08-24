import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:todo_app/models/repositories/quick_note_repository.dart';
import 'package:todo_app/routes/main/quick_note_page/quick_note_item.dart';


class QuickNotePage extends StatefulWidget {
  const QuickNotePage({ Key? key }) : super(key: key);

  @override
  _QuickNotePageState createState() => _QuickNotePageState();
}

class _QuickNotePageState extends State<QuickNotePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0, 
          title: Text('Quick Notes', style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: QuickNoteBody(),
      ),
    );
  }
}

class QuickNoteBody extends StatefulWidget {
  const QuickNoteBody({ Key? key }) : super(key: key);

  @override
  _QuickNoteBodyState createState() => _QuickNoteBodyState();
}

class _QuickNoteBodyState extends State<QuickNoteBody> {

  FirebaseQuickNoteRepository _quickNoteRepository = FirebaseQuickNoteRepository();
  late List<QuickNoteModel> quickNoteList;
  late Stream<List<QuickNoteModel>> streamQuickNoteList;

  @override
  void initState() {
    streamQuickNoteList = _quickNoteRepository.getStreamQuickNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: StreamBuilder<List<QuickNoteModel>>(
        stream: streamQuickNoteList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return QuickNoteItem(item: data[index], key: Key(data[index].id),);
            },
          );
        }
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return BlocListener<MainPageBloc, MainPageState>(
//       listener: (context, state){
//         if(state is Loading){
//           quickNoteList = _quickNoteRepository.getQuickNoteList();
//           context.read<MainPageBloc>().add(SwitchPage(pageIndex: 2));
//         }
//       },
//       child: Padding(
//         padding: EdgeInsets.only(top: 20),
//         child: ListView.builder(
//           itemCount: quickNoteList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return QuickNoteItem(item: quickNoteList[index]);
//           },
//         )
//       ),
//     );
//   }
