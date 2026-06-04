import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/task_controller.dart';

class StatsHeader extends StatelessWidget {
  const StatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final controller = Get.find<TaskController>();
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cs.primary, cs.primary.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: cs.primary.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                label: 'Total',
                value: controller.totalCount,
                icon: Icons.format_list_bulleted_rounded,
                iconBg: Colors.white.withOpacity(0.2),
              ),
            ),
            _Divider(),
            Expanded(
              child: _StatItem(
                label: 'Today',
                value: controller.todayCount,
                icon: Icons.today_rounded,
                iconBg: Colors.white.withOpacity(0.2),
              ),
            ),
            _Divider(),
            Expanded(
              child: _StatItem(
                label: 'Done',
                value: controller.completedCount,
                icon: Icons.check_circle_rounded,
                iconBg: Colors.white.withOpacity(0.2),
              ),
            ),
            _Divider(),
            Expanded(
              child: _StatItem(
                label: 'Pending',
                value: controller.pendingCount,
                icon: Icons.pending_rounded,
                iconBg: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withOpacity(0.25),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color iconBg;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}