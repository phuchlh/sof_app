import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sof_app/models/user_model.dart';
import 'package:sof_app/modules/reputation_history/reputation_history_controller.dart';
import 'package:sof_app/utils/gap.dart';

class BadgeWidget extends GetView<ReputationHistoryController> {
  final UserModel user;
  const BadgeWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isStatsLoading.value) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Column(
                children: [
                  Container(
                    width: k50,
                    height: k50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Gap(k4),
                  Container(
                    width: 40,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Gap(k2),
                  Container(
                    width: 30,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BadgeItem(
            count: user.badgeCounts?.gold ?? 0,
            color: const Color(0xFFFFD700), // Gold color
            icon: Icons.workspace_premium,
            label: 'Gold',
          ),
          _BadgeItem(
            count: user.badgeCounts?.silver ?? 0,
            color: const Color(0xFFC0C0C0), // Silver color
            icon: Icons.workspace_premium,
            label: 'Silver',
          ),
          _BadgeItem(
            count: user.badgeCounts?.bronze ?? 0,
            color: const Color(0xFFCD7F32), // Bronze color
            icon: Icons.workspace_premium,
            label: 'Bronze',
          ),
        ],
      );
    });
  }
}

class _BadgeItem extends StatelessWidget {
  final int count;
  final Color color;
  final String label;
  final IconData icon;

  const _BadgeItem({
    required this.count,
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: k50,
          height: k50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        Gap(k4),
        Text(
          count.toString(),
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
