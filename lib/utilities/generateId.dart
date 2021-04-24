import 'package:uuid/uuid.dart';

final uuid = Uuid();

String generateId() {
  return uuid.v4();
}
