import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/service/deep_link_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductShareHelper {
  static Future<void> shareProduct(
    BuildContext context, {
    required ProductDetail product,
    ProductVariant? selectedVariant,
    double? discountedPrice,
    String? displayPrice,
    int? discountPercentage,
  }) async {
    final l10n = context.l10n;
    final imagePath = selectedVariant?.imagePath ?? product.displayImage;

    // 1. Generate Deep Link
    final link = DeepLinkService.generateProductLink(product.id);

    // 2. Construct Share Text
    final shareMessage = StringBuffer()
      ..writeln('🌟 ${product.name} 🌟')
      ..writeln();

    // Add Attributes (like Color, Size) if selected
    if (selectedVariant != null &&
        selectedVariant.attributes != null &&
        selectedVariant.attributes!.isNotEmpty) {
      final attributesText = selectedVariant.attributes!.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ');
      shareMessage.writeln('✨ $attributesText');
    }

    // Add Price
    final priceText = discountedPrice != null
        ? '${discountedPrice.toStringAsFixed(0)} ${l10n.egp_text}'
        : '$displayPrice ${l10n.egp_text}';

    if (discountedPrice != null && discountPercentage != null) {
      shareMessage.writeln(
        '🔥 $discountPercentage% ${l10n.discount_text}! (${l10n.egp_text} $priceText) 🔥',
      );
    } else {
      shareMessage.writeln('💰 $priceText');
    }

    shareMessage
      ..writeln()
      ..writeln(l10n.check_it_out_on_mousa_store)
      ..writeln(link);

    // 3. Download Image (if available) and Share
    XFile? imageFile;
    if (imagePath.isNotEmpty) {
      try {
        imageFile = await _downloadImage(imagePath);
      } on Object catch (e) {
        debugPrint('Error downloading image for share: $e');
        // Fallback to text only if image fails
      }
    }

    await SharePlus.instance.share(
      ShareParams(
        text: shareMessage.toString(),
        subject: l10n.check_out_product_on_mousa_store(product.name),
        files: imageFile != null ? [imageFile] : null,
      ),
    );
  }

  static Future<XFile?> _downloadImage(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last;
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);

      // Check if we already have it to avoid re-downloading
      if (file.existsSync()) {
        return XFile(filePath);
      }

      final response = await Dio().download(url, filePath);
      if (response.statusCode == 200) {
        return XFile(filePath, mimeType: 'image/jpeg'); // Assuming JPEG/PNG
      }
      return null;
    } on Object catch (e) {
      debugPrint('Failed to download image: $e');
      rethrow;
    }
  }
}
