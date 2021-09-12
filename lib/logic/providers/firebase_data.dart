import 'stream_provider.dart';

class FirebaseDataProvider {
  FirebaseDataProvider() {
    if (uid.isNotEmpty) cache = StreamFromFirebase();
  }
  static String uid = '';
  static String email = '';
  late StreamFromFirebase cache;
}
