import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String filter;

  const EmptyState({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _icon(filter),
                size: 48,
                color: cs.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _title(filter),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _subtitle(filter),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(String filter) {
    switch (filter) {
      case 'completed':
        return Icons.check_circle_outline_rounded;
      case 'pending':
        return Icons.pending_outlined;
      case 'yesterday':
        return Icons.history_outlined;
      case 'today':
        return Icons.today_outlined;
      case 'future':
        return Icons.upcoming_outlined;
      default:
        return Icons.task_outlined;
    }
  }

  String _title(String filter) {
    switch (filter) {
      case 'completed':
        return 'No Completed Tasks';
      case 'pending':
        return 'All Caught Up!';
      case 'yesterday':
        return 'No Past Tasks';
      case 'today':
        return 'Nothing for Today';
      case 'future':
        return 'No Future Tasks';
      default:
        return 'No Tasks Yet';
    }
  }

  String _subtitle(String filter) {
    switch (filter) {
      case 'completed':
        return 'Complete some tasks to see them here.';
      case 'pending':
        return 'You have no pending tasks. Great job!';
      default:
        return 'Tap the + button to add your first task.';
    }
  }
}