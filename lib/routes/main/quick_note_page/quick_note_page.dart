import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_event.dart';
import 'package:todo_app/models/blocs/main_page/main_page_state.dart';
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

  FakeQuickNoteRepository _quickNoteRepository = FakeQuickNoteRepository();
  late List<QuickNoteModel> quickNoteList;

  @override
  void initState() {
    quickNoteList = _quickNoteRepository.getQuickNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainPageBloc, MainPageState>(
      listener: (context, state){
        if(state is Loading){
          quickNoteList = _quickNoteRepository.getQuickNoteList();
          context.read<MainPageBloc>().add(SwitchPage(pageIndex: 2));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: quickNoteList.length,
          itemBuilder: (BuildContext context, int index) {
            return QuickNoteItem(item: quickNoteList[index]);
          },
        )
      ),
    );
  }
}
