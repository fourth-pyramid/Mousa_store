import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/profile/cubit/contact_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<ContactCubit>();
      unawaited(cubit.getContactInfo());
      return cubit;
    },
    child: const _ContactUsContent(),
  );
}

class _ContactUsContent extends StatelessWidget {
  const _ContactUsContent();

  Future<void> _launchUrl(String? urlString, {String scheme = ''}) async {
    if (urlString == null || urlString.isEmpty) return;
    final uri = scheme.isNotEmpty
        ? Uri(scheme: scheme, path: urlString)
        : Uri.parse(urlString);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.contact_us_text.toUpperCase())),
    body: SafeArea(
      child: InternetStateManager(
        onRestoreInternetConnection: () =>
            context.read<ContactCubit>().getContactInfo(),
        noInternetScreen: const NoInternetScreen(),
        child: BlocBuilder<ContactCubit, ContactState>(
          builder: (context, state) {
            if (state case ContactError(:final message)) {
              return Center(
                child: Text(
                  message,
                  style: context.typography.bodySmall.copyWith(
                    color: context.colors.error,
                  ),
                ),
              );
            }

            final contact = switch (state) {
              ContactLoaded(:final contact) => contact,
              _ => null,
            };
            final isLoading =
                state is ContactLoading || state is ContactInitial;

            return Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Icon(
                          Icons.headset_mic_outlined,
                          size: 48.w,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.contact_us_text.toUpperCase(),
                      style: context.typography.titleMedium.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    if (contact?.phone != null || isLoading)
                      _ContactCard(
                        icon: Icons.phone_android_rounded,
                        title: context.l10n.phone_text,
                        subtitle: contact?.phone ?? 'Loading...',
                        onTap: () =>
                            _launchUrl('+20${contact?.phone}', scheme: 'tel'),
                      ),
                    SizedBox(height: 12.h),
                    if (contact?.email != null || isLoading)
                      _ContactCard(
                        icon: Icons.email_outlined,
                        title: context.l10n.email_text,
                        subtitle: contact?.email ?? 'Loading...',
                        onTap: () =>
                            _launchUrl(contact?.email, scheme: 'mailto'),
                      ),
                    SizedBox(height: 12.h),
                    if (contact?.address != null || isLoading)
                      _ContactCard(
                        icon: Icons.location_on_outlined,
                        title: context.l10n.address_text,
                        subtitle: contact?.address ?? 'Loading...',
                        onTap: () {},
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: context.radius.smBorder,
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: context.radius.smBorder),
      leading: Icon(icon, color: context.colors.textPrimary),
      title: Text(
        title,
        style: context.typography.body.copyWith(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.typography.bodySmall.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
      onTap: onTap,
    ),
  );
}
