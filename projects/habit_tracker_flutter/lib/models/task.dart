import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({required this.id, required this.iconName, required this.name});

  factory Task.create({required String name, required String iconName}) {
    final id = Uuid().v1();
    return Task(id: id, iconName: iconName, name: name);
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String iconName;
  @HiveField(2)
  final String name;
}
