
import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class TaskModel extends HiveObject {

@HiveField(0)
String id;

@HiveField(1)
String title;

@HiveField(2)
String description;

@HiveField(3)
DateTime date;

@HiveField(4)
bool isCompleted;

@HiveField(5)
DateTime createdAt;

TaskModel({
required this.id,
required this.title,
this.description = '',
required this.date,
this.isCompleted = false,
required this.createdAt,
});

/// Task Category Getter
TaskCategory get category {

final now = DateTime.now();

final today = DateTime(
now.year,
now.month,
now.day,
);

final taskDate = DateTime(
date.year,
date.month,
date.day,
);

if (taskDate.isBefore(today)) {
return TaskCategory.yesterday;
}

if (taskDate.isAtSameMomentAs(today)) {
return TaskCategory.today;
}

return TaskCategory.future;
}

/// Copy With
TaskModel copyWith({
String? id,
String? title,
String? description,
DateTime? date,
bool? isCompleted,
DateTime? createdAt,
}) {
return TaskModel(
id: id ?? this.id,
title: title ?? this.title,
description: description ?? this.description,
date: date ?? this.date,
isCompleted: isCompleted ?? this.isCompleted,
createdAt: createdAt ?? this.createdAt,
);
}

/// Toggle Completion
void toggleComplete() {
isCompleted = !isCompleted;
save();
}

@override
String toString() {
return '''
TaskModel(
  id: $id,
  title: $title,
  description: $description,
  date: $date,
  isCompleted: $isCompleted,
  createdAt: $createdAt
)
''';
}
}

/// Task Categories
enum TaskCategory {
yesterday,
today,
future,
}

