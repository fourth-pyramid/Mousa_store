import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.privacy_policy_text.toUpperCase())),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: context.l10n.privacy_text),
            _SectionContent(content: context.l10n.privacy_policy_intro),
            _SectionTitle(title: context.l10n.privacy_policy_sec1_title),
            _SectionContent(content: context.l10n.privacy_policy_sec1_desc),
            _SectionTitle(title: context.l10n.privacy_policy_sec2_title),
            _SectionContent(content: context.l10n.privacy_policy_sec2_desc),
            _SectionTitle(title: context.l10n.privacy_policy_sec3_title),
            _SectionContent(content: context.l10n.privacy_policy_sec3_desc),
            _SectionTitle(title: context.l10n.privacy_policy_sec4_title),
            _SectionContent(content: context.l10n.privacy_policy_sec4_desc),
            _SectionTitle(title: context.l10n.privacy_policy_sec5_title),
            _SectionContent(content: context.l10n.privacy_policy_sec5_desc),
            SizedBox(height: 32.h),
            Center(
              child: Text(
                context.l10n.privacy_policy_copyright,
                style: context.typography.caption.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
    child: Text(
      title.toUpperCase(),
      style: context.typography.titleMedium.copyWith(
        color: context.colors.textPrimary,
      ),
    ),
  );
}

class _SectionContent extends StatelessWidget {
  const _SectionContent({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) => Text(
    content,
    style: context.typography.body.copyWith(
      color: context.colors.textSecondary,
    ),
  );
}
