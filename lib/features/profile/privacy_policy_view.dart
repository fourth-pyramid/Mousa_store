import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.privacy_policy_text.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, context.l10n.privacy_text),
            _buildSectionContent(context, context.l10n.privacy_policy_intro),
            _buildSectionTitle(context, context.l10n.privacy_policy_sec1_title),
            _buildSectionContent(context, context.l10n.privacy_policy_sec1_desc),
            _buildSectionTitle(context, context.l10n.privacy_policy_sec2_title),
            _buildSectionContent(context, context.l10n.privacy_policy_sec2_desc),
            _buildSectionTitle(context, context.l10n.privacy_policy_sec3_title),
            _buildSectionContent(context, context.l10n.privacy_policy_sec3_desc),
            _buildSectionTitle(context, context.l10n.privacy_policy_sec4_title),
            _buildSectionContent(context, context.l10n.privacy_policy_sec4_desc),
            _buildSectionTitle(context, context.l10n.privacy_policy_sec5_title),
            _buildSectionContent(context, context.l10n.privacy_policy_sec5_desc),
            SizedBox(height: 32.h),
            Center(
              child: Text(
                context.l10n.privacy_policy_copyright,
                style: context.typography.caption.copyWith(color: context.colors.textSecondary),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );

  Widget _buildSectionTitle(BuildContext context, String title) => Padding(
    padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
    child: Text(
      title.toUpperCase(),
      style: context.typography.titleMedium.copyWith(color: context.colors.textPrimary),
    ),
  );

  Widget _buildSectionContent(BuildContext context, String content) => Text(
    content,
    style: context.typography.body.copyWith(color: context.colors.textSecondary),
  );
}
