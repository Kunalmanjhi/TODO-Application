import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/stats_header.dart';
import 'package:todo_app/task_bottom_sheet.dart';
import 'package:todo_app/task_card.dart';
import 'package:todo_app/task_controller.dart';
import 'package:todo_app/theme_controller.dart';

import 'Empty_state.dart';
import 'TaskModel.dart';
import 'filter_chip_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCtrl = Get.find<TaskController>();
    final themeCtrl = Get.find<ThemeController>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Tasks',
              style: theme.appBarTheme.titleTextStyle,
            ),
            Text(
              DateFormat('EEEE, MMMM d').format(now),
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Obx(
                () => IconButton(
              tooltip: 'Toggle Theme',
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  themeCtrl.isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  key: ValueKey(themeCtrl.isDarkMode),
                ),
              ),
              onPressed: themeCtrl.toggleTheme,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const StatsHeader(),
          const SizedBox(height: 12),
          const FilterChipRow(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final tasks = taskCtrl.filteredTasks;

              if (tasks.isEmpty) {
                return EmptyState(filter: taskCtrl.selectedFilter.name);
              }

              // Group tasks by category
              final grouped = <TaskCategory, List<TaskModel>>{};
              for (final task in tasks) {
                grouped.putIfAbsent(task.category, () => []).add(task);
              }

              final categoryOrder = [
                TaskCategory.today,
                TaskCategory.yesterday,
                TaskCategory.future,
              ];

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100, top: 4),
                itemCount: _countItems(grouped, categoryOrder),
                itemBuilder: (context, index) {
                  return _buildItem(context, index, grouped, categoryOrder);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTask(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Task',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  int _countItems(
      Map<TaskCategory, List<TaskModel>> grouped,
      List<TaskCategory> order,
      ) {
    int count = 0;
    for (final cat in order) {
      final tasks = grouped[cat];
      if (tasks != null && tasks.isNotEmpty) {
        count += 1 + tasks.length; // header + tasks
      }
    }
    return count;
  }

  Widget _buildItem(
      BuildContext context,
      int index,
      Map<TaskCategory, List<TaskModel>> grouped,
      List<TaskCategory> order,
      ) {
    int cursor = 0;
    for (final cat in order) {
      final tasks = grouped[cat];
      if (tasks == null || tasks.isEmpty) continue;

      if (index == cursor) {
        return _CategoryHeader(category: cat, count: tasks.length);
      }
      cursor++;

      for (final task in tasks) {
        if (index == cursor) {
          return TaskCard(
            task: task,
            onEdit: () => _showEditTask(context, task),
          );
        }
        cursor++;
      }
    }
    return const SizedBox.shrink();
  }

  void _showAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TaskBottomSheet(),
    );
  }

  void _showEditTask(BuildContext context, TaskModel task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskBottomSheet(task: task),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final TaskCategory category;
  final int count;

  const _CategoryHeader({required this.category, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    String label;
    IconData icon;
    Color color;

    switch (category) {
      case TaskCategory.yesterday:
        label = 'Yesterday';
        icon = Icons.history_rounded;
        color = const Color(0xFFFF6584);
        break;
      case TaskCategory.today:
        label = 'Today';
        icon = Icons.today_rounded;
        color = cs.primary;
        break;
      case TaskCategory.future:
        label = 'Upcoming';
        icon = Icons.upcoming_rounded;
        color = const Color(0xFF00BFA5);
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}