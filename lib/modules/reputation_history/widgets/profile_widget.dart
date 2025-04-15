import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sof_app/models/user_model.dart';
import 'package:sof_app/modules/reputation_history/reputation_history_controller.dart';
import 'package:sof_app/modules/reputation_history/widgets/badge_widget.dart';
import 'package:sof_app/utils/gap.dart';
import 'package:sof_app/utils/helper.dart';
import '../../../common/stat_item.dart';

class ProfileWidget extends GetView<ReputationHistoryController> {
  final UserModel user;
  const ProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(k16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child:
                    controller.isStatsLoading.value
                        ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [_ShimmerStatItem(), _ShimmerStatItem(), _ShimmerStatItem(), _ShimmerStatItem()],
                              ),
                            ],
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatItem(value: Helper.formatReputation(user.reputation ?? 0), label: 'reputation'),
                            StatItem(value: Helper.formatReputation(controller.totalAnswer.value), label: 'answers'),
                            StatItem(value: Helper.formatReputation(controller.totalQuestion.value), label: 'questions'),
                            StatItem(value: Helper.formatReputation(controller.totalComment.value), label: 'comments'),
                          ],
                        ),
              ), // Badges
              Gap(k20),
              Text('Badges', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Gap(k8),
              BadgeWidget(user: user),
              Gap(k20),
              Text('Languages', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Gap(k8),
              Obx(() {
                if (controller.isGetLanguages.value) {
                  return Wrap(
                    spacing: k4,
                    runSpacing: k4,
                    children: List.generate(
                      6,
                      (index) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: k12, vertical: k6),
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
                          child: Text('█████████', style: context.textTheme.bodyMedium?.copyWith(color: Colors.transparent)),
                        ),
                      ),
                    ),
                  );
                }

                if (controller.languageModel.isEmpty) {
                  return const Center(child: Text('This user has no active languages'));
                }

                return Wrap(
                  spacing: k10,
                  runSpacing: k2,
                  children:
                      controller.languageModel.map((lang) {
                        return Chip(
                          label: Text(
                            '${lang.name ?? ''} (${lang.count ?? 0})',
                            style: context.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onPrimaryContainer),
                          ),
                          backgroundColor: context.theme.colorScheme.primaryContainer,
                          padding: const EdgeInsets.symmetric(horizontal: k2, vertical: 0),
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.transparent), // <-- no border
                          ),
                        );
                      }).toList(),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}

class _ShimmerStatItem extends StatelessWidget {
  const _ShimmerStatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
          ),
          const Gap(4),
          Container(
            width: 60,
            height: 16,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }
}
