import 'stream_provider.dart';

class FirebaseDataProvider {
  FirebaseDataProvider() {
    if (uid.isNotEmpty) streamFromFirebase = StreamFromFirebase();
  }
  static String uid = '';
  static String email = '';
  late StreamFromFirebase streamFromFirebase;
}
