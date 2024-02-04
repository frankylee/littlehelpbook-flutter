import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/providers_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';

class ProvidersByServiceScreen extends ConsumerWidget {
  const ProvidersByServiceScreen({
    super.key,
    required this.serviceId,
    required this.serviceName,
  });

  final ServiceId serviceId;
  final String serviceName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<ServiceProvider>>>(
      providersByServiceProvider(serviceId),
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(serviceName),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LhbStyleConstants.maxPageContentWidth,
          ),
          child: ref.watch(providersByServiceProvider(serviceId)).maybeWhen(
                data: (data) => ProvidersList(providers: data),
                orElse: () => Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}
