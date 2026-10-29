import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

/// Represents a parsed phone number with country metadata.
class PhoneNumber {
  const PhoneNumber({
    required this.countryCode,
    required this.countryISOCode,
    required this.number,
  });

  /// Dialing code without '+' (e.g., '20').
  final String countryCode;

  /// ISO 3166-1 alpha-2 code (e.g., 'EG').
  final String countryISOCode;

  /// National phone number without international prefix.
  final String number;

  /// Full international phone number formatted as `+<countryCode><nationalNumber>`.
  /// Strips leading zero from the national number for standard international dialing.
  String get completeNumber {
    final cleanNum = number.startsWith('0') ? number.substring(1) : number;
    final cleanCode = countryCode.replaceAll('+', '').trim();
    if (cleanNum.isEmpty) return '';
    return '+$cleanCode$cleanNum';
  }

  @override
  String toString() => completeNumber;
}

/// Country metadata for phone input and dialing code.
class Country {
  const Country({
    required this.name,
    required this.nameAr,
    required this.isoCode,
    required this.dialCode,
    required this.flag,
    this.minLength = 8,
    this.maxLength = 11,
  });

  final String name;
  final String nameAr;
  final String isoCode;
  final String dialCode;
  final String flag;
  final int minLength;
  final int maxLength;

  String localizedName(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return isAr ? nameAr : name;
  }
}

/// Standard country directory focusing on Egypt, MENA, and international regions.
const List<Country> kSupportedCountries = [
  Country(
    name: 'Egypt',
    nameAr: 'مصر',
    isoCode: 'EG',
    dialCode: '20',
    flag: '🇪🇬',
    minLength: 10,
  ),
  Country(
    name: 'Saudi Arabia',
    nameAr: 'المملكة العربية السعودية',
    isoCode: 'SA',
    dialCode: '966',
    flag: '🇸🇦',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'United Arab Emirates',
    nameAr: 'الإمارات العربية المتحدة',
    isoCode: 'AE',
    dialCode: '971',
    flag: '🇦🇪',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Kuwait',
    nameAr: 'الكويت',
    isoCode: 'KW',
    dialCode: '965',
    flag: '🇰🇼',
    maxLength: 8,
  ),
  Country(
    name: 'Qatar',
    nameAr: 'قطر',
    isoCode: 'QA',
    dialCode: '974',
    flag: '🇶🇦',
    maxLength: 8,
  ),
  Country(
    name: 'Bahrain',
    nameAr: 'البحرين',
    isoCode: 'BH',
    dialCode: '973',
    flag: '🇧🇭',
    maxLength: 8,
  ),
  Country(
    name: 'Oman',
    nameAr: 'عمان',
    isoCode: 'OM',
    dialCode: '968',
    flag: '🇴🇲',
    maxLength: 8,
  ),
  Country(
    name: 'Jordan',
    nameAr: 'الأردن',
    isoCode: 'JO',
    dialCode: '962',
    flag: '🇯🇴',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Iraq',
    nameAr: 'العراق',
    isoCode: 'IQ',
    dialCode: '964',
    flag: '🇮🇶',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Lebanon',
    nameAr: 'لبنان',
    isoCode: 'LB',
    dialCode: '961',
    flag: '🇱🇧',
    minLength: 7,
    maxLength: 8,
  ),
  Country(
    name: 'Palestine',
    nameAr: 'فلسطين',
    isoCode: 'PS',
    dialCode: '970',
    flag: '🇵🇸',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Morocco',
    nameAr: 'المغرب',
    isoCode: 'MA',
    dialCode: '212',
    flag: '🇲🇦',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Tunisia',
    nameAr: 'تونس',
    isoCode: 'TN',
    dialCode: '216',
    flag: '🇹🇳',
    maxLength: 8,
  ),
  Country(
    name: 'Algeria',
    nameAr: 'الجزائر',
    isoCode: 'DZ',
    dialCode: '213',
    flag: '🇩🇿',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Libya',
    nameAr: 'ليبيا',
    isoCode: 'LY',
    dialCode: '218',
    flag: '🇱🇾',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Sudan',
    nameAr: 'السودان',
    isoCode: 'SD',
    dialCode: '249',
    flag: '🇸🇩',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Yemen',
    nameAr: 'اليمن',
    isoCode: 'YE',
    dialCode: '967',
    flag: '🇾🇪',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'United States',
    nameAr: 'الولايات المتحدة',
    isoCode: 'US',
    dialCode: '1',
    flag: '🇺🇸',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'United Kingdom',
    nameAr: 'المملكة المتحدة',
    isoCode: 'GB',
    dialCode: '44',
    flag: '🇬🇧',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Germany',
    nameAr: 'ألمانيا',
    isoCode: 'DE',
    dialCode: '49',
    flag: '🇩🇪',
    minLength: 10,
  ),
  Country(
    name: 'France',
    nameAr: 'فرنسا',
    isoCode: 'FR',
    dialCode: '33',
    flag: '🇫🇷',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'Turkey',
    nameAr: 'تركيا',
    isoCode: 'TR',
    dialCode: '90',
    flag: '🇹🇷',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Canada',
    nameAr: 'كندا',
    isoCode: 'CA',
    dialCode: '1',
    flag: '🇨🇦',
    minLength: 10,
    maxLength: 10,
  ),
];

/// A pure Flutter SDK phone input with country selector, validation, and formatting.
class AppPhoneField extends StatefulWidget {
  const AppPhoneField({
    this.initialCountryCode = 'EG',
    this.initialValue,
    this.controller,
    this.onChanged,
    this.invalidNumberMessage,
    this.dialogTitle,
    this.searchTextStyle,
    this.decoration = const InputDecoration(),
    this.searchFieldInputDecoration = const InputDecoration(),
    this.enabled = true,
    super.key,
  });

  final String initialCountryCode;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<PhoneNumber>? onChanged;
  final String? invalidNumberMessage;
  final String? dialogTitle;
  final TextStyle? searchTextStyle;
  final InputDecoration decoration;
  final InputDecoration searchFieldInputDecoration;
  final bool enabled;

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  late Country _selectedCountry;
  late TextEditingController _numberController;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = kSupportedCountries.firstWhere(
      (c) => c.isoCode.toUpperCase() == widget.initialCountryCode.toUpperCase(),
      orElse: () => kSupportedCountries.first,
    );

    if (widget.controller != null) {
      _numberController = widget.controller!;
    } else {
      _numberController = TextEditingController(
        text: widget.initialValue ?? '',
      );
      _ownsController = true;
    }

    _numberController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant AppPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _numberController.removeListener(_onTextChanged);
      if (_ownsController) {
        _numberController.dispose();
      }
      _numberController = widget.controller ?? TextEditingController();
      _ownsController = widget.controller == null;
      _numberController.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _numberController.removeListener(_onTextChanged);
    if (_ownsController) {
      _numberController.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final rawText = _numberController.text.trim();

    // Check if user pasted an international number starting with + or 00
    if (rawText.startsWith('+') || rawText.startsWith('00')) {
      final normalized = rawText.startsWith('00')
          ? rawText.substring(2)
          : rawText.substring(1);

      for (final country in kSupportedCountries) {
        if (normalized.startsWith(country.dialCode)) {
          final nationalNum = normalized.substring(country.dialCode.length);
          _selectedCountry = country;
          if (_numberController.text != nationalNum) {
            _numberController.text = nationalNum;
            _numberController.selection = TextSelection.collapsed(
              offset: nationalNum.length,
            );
            setState(() {});
            return;
          }
          setState(() {});
          break;
        }
      }
    }

    final phoneNumber = PhoneNumber(
      countryCode: _selectedCountry.dialCode,
      countryISOCode: _selectedCountry.isoCode,
      number: _numberController.text.trim(),
    );

    widget.onChanged?.call(phoneNumber);
  }

  String? _validate(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return widget.invalidNumberMessage ?? 'Invalid phone number';
    }

    // Must contain only digits
    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return widget.invalidNumberMessage ?? 'Invalid phone number';
    }

    // Specific validation for Egypt (EG +20)
    if (_selectedCountry.isoCode == 'EG') {
      final stripped = text.startsWith('0') ? text.substring(1) : text;
      // Egyptian mobile numbers are 10 digits without leading 0 (starts with 10, 11, 12, 15)
      // or 11 digits with leading 0 (010, 011, 012, 015)
      if (stripped.length != 10 ||
          !RegExp(r'^1[0125]\d{8}$').hasMatch(stripped)) {
        return widget.invalidNumberMessage ?? 'Invalid phone number';
      }
      return null;
    }

    // Standard length bounds for other supported countries
    final stripped = text.startsWith('0') ? text.substring(1) : text;
    if (stripped.length < _selectedCountry.minLength ||
        stripped.length > _selectedCountry.maxLength) {
      return widget.invalidNumberMessage ?? 'Invalid phone number';
    }

    return null;
  }

  Future<void> _openCountryPicker() async {
    final selected = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CountryPickerSheet(
        searchFieldDecoration: widget.searchFieldInputDecoration,
        searchTextStyle: widget.searchTextStyle,
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _selectedCountry = selected;
      });
      _onTextChanged();
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: _numberController,
    enabled: widget.enabled,
    keyboardType: TextInputType.phone,
    style: context.typography.body.copyWith(color: context.colors.textPrimary),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
      LengthLimitingTextInputFormatter(_selectedCountry.maxLength + 4),
    ],
    validator: _validate,
    decoration: widget.decoration.copyWith(
      prefixIcon: GestureDetector(
        onTap: widget.enabled ? _openCountryPicker : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsetsDirectional.only(end: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_selectedCountry.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  '+${_selectedCountry.dialCode}',
                  style: context.typography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: context.colors.textSecondary,
                size: 20,
              ),
              Container(
                height: 20,
                width: 1,
                color: context.colors.border,
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet({
    required this.searchFieldDecoration,
    this.searchTextStyle,
  });

  final InputDecoration searchFieldDecoration;
  final TextStyle? searchTextStyle;

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = kSupportedCountries;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filter);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filter() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = kSupportedCountries;
      } else {
        _filteredCountries = kSupportedCountries
            .where(
              (c) =>
                  c.name.toLowerCase().contains(query) ||
                  c.nameAr.contains(query) ||
                  c.dialCode.contains(query) ||
                  c.isoCode.toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.72,
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: widget.searchTextStyle ?? context.typography.body,
              decoration: widget.searchFieldDecoration.copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: context.colors.surfaceStrong,
                border: OutlineInputBorder(
                  borderRadius: context.radius.mdBorder,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // List of countries
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredCountries.length,
              separatorBuilder: (_, _) => Divider(
                color: context.colors.border.withValues(alpha: 0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    country.localizedName(context),
                    style: context.typography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  trailing: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '+${country.dialCode}',
                      style: context.typography.bodySmall.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(country),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
