import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
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
      appBar: AppBar(
        title: Text(context.l10n.contact_us_text.toUpperCase()),
      ),
      body: InternetStateManager(
        onRestoreInternetConnection: () =>
            context.read<ContactCubit>().getContactInfo(),
        noInternetScreen: const NoInternetScreen(),
        child: BlocBuilder<ContactCubit, ContactState>(
          builder: (context, state) {
            if (state is ContactError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.typography.bodySmall.copyWith(color: context.colors.error),
                ),
              );
            }

            final contact = state is ContactLoaded ? state.contact : null;
            final isLoading = state is ContactLoading || state is ContactInitial;

            return Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.headset_mic_outlined,
                        size: 48.w,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.contact_us_text.toUpperCase(),
                      style: context.typography.titleMedium.copyWith(color: context.colors.textPrimary),
                    ),
                    SizedBox(height: 32.h),
                    if (contact?.phone != null || isLoading)
                      _buildContactCard(
                        context,
                        icon: Icons.phone_android_rounded,
                        title: context.l10n.phone_text,
                        subtitle: contact?.phone ?? 'Loading...',
                        onTap: () => _launchUrl('+20${contact?.phone}', scheme: 'tel'),
                      ),
                    SizedBox(height: 12.h),
                    if (contact?.email != null || isLoading)
                      _buildContactCard(
                        context,
                        icon: Icons.email_outlined,
                        title: context.l10n.email_text,
                        subtitle: contact?.email ?? 'Loading...',
                        onTap: () => _launchUrl(contact?.email, scheme: 'mailto'),
                      ),
                    SizedBox(height: 12.h),
                    if (contact?.address != null || isLoading)
                      _buildContactCard(
                        context,
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
    );

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) => Material(
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
          style: context.typography.bodySmall.copyWith(color: context.colors.textSecondary),
        ),
        onTap: onTap,
      ),
    );
}
