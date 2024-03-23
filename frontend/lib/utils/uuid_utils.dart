import 'package:uuid/uuid.dart';

class UUIDUtils {
  static const uuid = Uuid();

  static String generateId(){
    return uuid.v8();
  }
}