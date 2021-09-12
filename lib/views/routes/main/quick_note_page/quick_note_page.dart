import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/views/routes/main/quick_note_page/quick_note_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickNotePage extends StatefulWidget {
  const QuickNotePage({Key? key}) : super(key: key);

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
          title: Text('Quick Notes',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: QuickNoteBody(),
      ),
    );
  }
}

class QuickNoteBody extends StatefulWidget {
  const QuickNoteBody({Key? key}) : super(key: key);

  @override
  _QuickNoteBodyState createState() => _QuickNoteBodyState();
}

class _QuickNoteBodyState extends State<QuickNoteBody> {
  late Stream<List<QuickNoteModel>> quickNoteList;
  late AuthState authState;

  @override
  void initState() {    
    authState = BlocProvider.of<AuthBloc>(context).state;
    // print(authState.toString());
    if (authState is LoggeddUser) {
      quickNoteList = (authState as LoggeddUser)
          .firebaseDataProvider
          .streamFromFirebase
          .allQuickNoteList;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: StreamBuilder<List<QuickNoteModel>>(
          stream: quickNoteList,
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
                return QuickNoteItem(
                  item: data[index],
                  key: Key(data[index].id),
                );
              },
            );
          }),
    );
  }
}
