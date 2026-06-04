import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'TaskModel.dart';

enum FilterType { all, yesterday, today, future, completed, pending }

class TaskController extends GetxController {
  static const String _boxName = 'tasks';
  late Box<TaskModel> _taskBox;

  final _tasks = <TaskModel>[].obs;
  final _selectedFilter = FilterType.all.obs;

  FilterType get selectedFilter => _selectedFilter.value;

  List<TaskModel> get filteredTasks {
    final all = _tasks.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    switch (_selectedFilter.value) {
      case FilterType.all:
        return all;
      case FilterType.yesterday:
        return all
            .where((t) => t.category == TaskCategory.yesterday)
            .toList();
      case FilterType.today:
        return all.where((t) => t.category == TaskCategory.today).toList();
      case FilterType.future:
        return all.where((t) => t.category == TaskCategory.future).toList();
      case FilterType.completed:
        return all.where((t) => t.isCompleted).toList();
      case FilterType.pending:
        return all.where((t) => !t.isCompleted).toList();
    }
  }

  // Counts for badges
  int get totalCount => _tasks.length;
  int get todayCount =>
      _tasks.where((t) => t.category == TaskCategory.today).length;
  int get completedCount => _tasks.where((t) => t.isCompleted).length;
  int get pendingCount => _tasks.where((t) => !t.isCompleted).length;

  @override
  void onInit() {
    super.onInit();
    _taskBox = Hive.box<TaskModel>(_boxName);
    _loadTasks();
  }

  void _loadTasks() {
    _tasks.assignAll(_taskBox.values.toList());
  }

  void setFilter(FilterType filter) {
    _selectedFilter.value = filter;
  }

  // ─── CRUD ──────────────────────────────────────────────────────────────────
  Future<void> addTask({
    required String title,
    String description = '',
    required DateTime date,
  }) async {
    final task = TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
      date: date,
      createdAt: DateTime.now(),
    );
    await _taskBox.put(task.id, task);
    _tasks.add(task);
    _tasks.refresh();
  }

  Future<void> updateTask({
    required String id,
    required String title,
    String description = '',
    required DateTime date,
  }) async {
    final existingTask = _taskBox.get(id);
    if (existingTask == null) return;

    final updated = existingTask.copyWith(
      title: title,
      description: description,
      date: date,
    );
    await _taskBox.put(id, updated);
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = updated;
      _tasks.refresh();
    }
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
    _tasks.removeWhere((t) => t.id == id);
  }

  Future<void> toggleCompletion(String id) async {
    final task = _taskBox.get(id);
    if (task == null) return;

    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await _taskBox.put(id, updated);
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = updated;
      _tasks.refresh();
    }
  }

  // ─── Grouped by Category ───────────────────────────────────────────────────
  Map<TaskCategory, List<TaskModel>> get groupedTasks {
    final result = <TaskCategory, List<TaskModel>>{};
    for (final task in filteredTasks) {
      result.putIfAbsent(task.category, () => []).add(task);
    }
    return result;
  }
}