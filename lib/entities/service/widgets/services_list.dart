import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';

class ServicesList extends ConsumerWidget {
  const ServicesList({
    super.key,
    required this.services,
    required this.onTap,
  });

  final List<Service> services;
  final void Function(Service service) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userPreferencesProvider);
    final isEn = ref.read(userPreferencesProvider.notifier).isEn();
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ListTile(
          title: Text(service.getNamePrimary(isEn)),
          subtitle: Text(service.getNameSecondary(isEn)),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () => onTap(service),
        );
      },
    );
  }
}
