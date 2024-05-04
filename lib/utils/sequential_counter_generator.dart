import 'package:injector/injector.dart';
import 'package:pocketbase/pocketbase.dart';

class SequentialIdGenerator {
  late final PocketBase pb;

  SequentialIdGenerator() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }

  Future<int> getNextSequence(String collection) {
    return pb
        .collection(collection)
        .getList(
          page: 1,
          sort: '-created',
          fields: "consecutivo",
        )
        .then((value) {
      return value.items.isEmpty
          ? 1
          : (value.items.first.data['consecutivo'] as int) + 1;
    });
  }
}
