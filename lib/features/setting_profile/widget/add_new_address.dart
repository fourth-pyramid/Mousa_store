import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/core/utils/address_formatter.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/governorates_data.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/setting_profile/model/address_model.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key, this.address});
  final Address? address;

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;

  final ValueNotifier<String?> _selectedGovernorateNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _streetFocus = FocusNode();

  final List<String> governorates = egyptGovernoratesList.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();
    String? initialGovernorate;
    var initialAddressText = widget.address?.address ?? '';

    if (widget.address != null) {
      for (final gov in governorates) {
        if (initialAddressText.startsWith('$gov - ')) {
          initialGovernorate = gov;
          initialAddressText = initialAddressText.substring(gov.length + 3);
          break;
        } else if (initialAddressText == gov) {
          initialGovernorate = gov;
          initialAddressText = '';
          break;
        }
      }

      if (initialGovernorate == null &&
          widget.address!.governorate != null &&
          governorates.contains(widget.address!.governorate)) {
        initialGovernorate = widget.address!.governorate;
      }
    }

    _nameController = TextEditingController(text: widget.address?.nameAddress);
    _cityController = TextEditingController();
    _streetController = TextEditingController();
    _selectedGovernorateNotifier.value = initialGovernorate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _nameFocus.dispose();
    _cityFocus.dispose();
    _streetFocus.dispose();
    _selectedGovernorateNotifier.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<bool> _submitForm() async {
    if (!_formKey.currentState!.validate()) return false;
    if (_selectedGovernorateNotifier.value == null) return false;

    final fullAddress = '${_selectedGovernorateNotifier.value} - ${_cityController.text} - ${_streetController.text}';

    try {
      if (widget.address == null) {
        await DioHelper.postData(
          url: 'address/create',
          data: {
            'name_address': _nameController.text,
            'address': fullAddress,
            'governorate': _selectedGovernorateNotifier.value,
          },
        );
      } else {
        await DioHelper.putData(
          url: 'address/update',
          data: {
            'address_id': widget.address!.id.toString(),
            'name_address': _nameController.text,
            'address': fullAddress,
            'governorate': _selectedGovernorateNotifier.value,
          },
        );
      }
      return true;
    } on Object {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.address == null ? context.l10n.add_new_address_text : context.l10n.edit_address_title_text),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    hint: context.l10n.address_name_text,
                    validator: (value) => value == null || value.isEmpty ? context.l10n.required_text : null,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _selectedGovernorateNotifier,
                    builder: (context, selectedGovernorate, _) => DropdownButtonFormField<String>(
                      initialValue: selectedGovernorate,
                      decoration: InputDecoration(
                        labelText: context.l10n.governorate_text,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        border: OutlineInputBorder(borderRadius: context.radius.smBorder),
                      ),
                      items: governorates
                          .map((value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                          .toList(),
                      onChanged: (val) {
                        _selectedGovernorateNotifier.value = val;
                      },
                      validator: (value) => value == null || value.isEmpty ? context.l10n.required_text : null,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            CustomFormField(
              controller: _cityController,
              focusNode: _cityFocus,
              hint: context.l10n.city_text,
              inputFormatters: [AddressFormatter()],
              validator: (value) => value == null || value.isEmpty ? context.l10n.required_text : null,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              controller: _streetController,
              focusNode: _streetFocus,
              hint: context.l10n.street_text,
              inputFormatters: [AddressFormatter()],
              validator: (value) => value == null || value.isEmpty ? context.l10n.required_text : null,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 16.h),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isLoadingNotifier,
          builder: (context, isLoading, _) => CustomButton(
            isLoading: isLoading,
            onPressed: () async {
              _isLoadingNotifier.value = true;

              try {
                final success = await _submitForm();
                if (success && context.mounted) {
                  Navigator.pop(context, true);
                }
              } finally {
                _isLoadingNotifier.value = false;
              }
            },
            text: Text(widget.address == null ? context.l10n.add_text : context.l10n.edit_text),
          ),
        ),
      ),
    ),
  );
}
