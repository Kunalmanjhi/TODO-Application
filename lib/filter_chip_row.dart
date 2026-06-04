import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/task_controller.dart';


class FilterChipRow extends StatelessWidget {
  const FilterChipRow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final selected = controller.selectedFilter;
      return SizedBox(
        height: 44,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: FilterType.values.map((filter) {
            final isSelected = selected == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_filterLabel(filter)),
                selected: isSelected,
                onSelected: (_) => controller.setFilter(filter),
                showCheckmark: false,
                avatar: Icon(
                  _filterIcon(filter),
                  size: 16,
                  color: isSelected ? Colors.white : cs.primary,
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : cs.onSurface.withOpacity(0.75),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                backgroundColor: cs.surfaceContainerHighest,
                selectedColor: cs.primary,
                side: BorderSide.none,
                elevation: isSelected ? 3 : 0,
                shadowColor: cs.primary.withOpacity(0.3),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  String _filterLabel(FilterType filter) {
    switch (filter) {
      case FilterType.all:
        return 'All';
      case FilterType.yesterday:
        return 'Yesterday';
      case FilterType.today:
        return 'Today';
      case FilterType.future:
        return 'Future';
      case FilterType.completed:
        return 'Completed';
      case FilterType.pending:
        return 'Pending';
    }
  }

  IconData _filterIcon(FilterType filter) {
    switch (filter) {
      case FilterType.all:
        return Icons.apps_rounded;
      case FilterType.yesterday:
        return Icons.history_rounded;
      case FilterType.today:
        return Icons.today_rounded;
      case FilterType.future:
        return Icons.upcoming_rounded;
      case FilterType.completed:
        return Icons.check_circle_rounded;
      case FilterType.pending:
        return Icons.pending_rounded;
    }
  }
}