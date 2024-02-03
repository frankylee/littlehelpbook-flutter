import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/location_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/shared/models/schedule.dart';

class HoursOfOperation extends ConsumerWidget {
  const HoursOfOperation({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Schedule>>>(
      schedulesByLocationProvider(location.id),
      (_, state) => state.showSnackbarOnError(
        context,
        message: context.l10n.hoursOfOperationNotFound,
      ),
    );
    return ref.watch(schedulesByLocationProvider(location.id)).maybeWhen(
          data: (schedules) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (schedules.isNotEmpty) const SizedBox(height: 16.0),
              if (schedules.isNotEmpty)
                Text(
                  context.l10n.hoursOfOperationLabel,
                  style: context.textTheme.bodyMedium?.white
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ...List.generate(
                schedules.length,
                (ind) {
                  final schedule = schedules[ind];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${schedule.opensAt?.format(context)}—${schedule.closesAt?.format(context)}",
                        softWrap: true,
                        style: context.textTheme.bodyMedium?.white,
                      ),
                      const SizedBox(width: 24.0),
                      Text(
                        "${schedule.formatSchedule(context)}",
                        softWrap: true,
                        style: context.textTheme.bodyMedium?.white,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          orElse: () => const SizedBox.shrink(),
        );
  }
}
