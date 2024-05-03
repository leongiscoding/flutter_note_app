import 'package:isar/isar.dart';

// we need to generate this file to store data
// run : dart run build_runner_build
part 'note.g.dart';

@Collection()
class Note{
  Id id = Isar.autoIncrement;
  late String text;
}