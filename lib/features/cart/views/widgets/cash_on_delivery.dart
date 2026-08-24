// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/core/utils/address_formatter.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/governorates_data.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/cart/viewmodels/checkout_cubit.dart';
import 'package:mousa_store/features/setting_profile/model/address_model.dart';

class CashOnDelivery extends StatelessWidget {
  const CashOnDelivery({required this.totalPrice, super.key});
  final String totalPrice;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<CheckoutCubit>(),
    child: _CashOnDeliveryContent(totalPrice: totalPrice),
  );
}

class _CashOnDeliveryContent extends StatefulWidget {
  const _CashOnDeliveryContent({required this.totalPrice});
  final String totalPrice;

  @override
  State<_CashOnDeliveryContent> createState() => _CashOnDeliveryContentState();
}

class _CashOnDeliveryContentState extends State<_CashOnDeliveryContent> {
  final ValueNotifier<_CheckoutFormState> _formStateNotifier = ValueNotifier(const _CheckoutFormState());

  final TextEditingController _tempCityController = TextEditingController();
  final TextEditingController _tempStreetController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isDisposed = false;

  late Future<List<Address>> _addressesFuture;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    _addressesFuture = _fetchAddresses();
  }

  void _initializeUserData() {
    final user = getIt<AuthService>().user;
    if (user == null) return;

    _fullNameController.text = '${user.firstName} ${user.lastName}'.trim();
    _phoneController.text = user.phone;
  }

  Future<List<Address>> _fetchAddresses() async {
    try {
      final response = await DioHelper.getData(url: 'address');
      final data = response.data as Map<String, dynamic>;
      final innerData = data['data'] as Map<String, dynamic>;
      final listData = innerData['data'] as List;
      final addresses = listData.map((e) => Address.fromJson(e as Map<String, dynamic>)).toList();

      if (_isDisposed) return [];

      if (addresses.isNotEmpty) {
        final firstAddress = addresses.first;
        if (mounted) _selectAddress(firstAddress);
      } else {
        if (mounted) {
          unawaited(context.read<CheckoutCubit>().getShippingFee());
        }
      }
      return addresses;
    } on Object catch (_) {
      if (_isDisposed) return [];
      if (mounted) {
        CustomSnackBar.show(context, 'Failed to load addresses');
        unawaited(context.read<CheckoutCubit>().getShippingFee());
      }
      return [];
    }
  }

  void _selectAddress(Address address) {
    var govName = address.governorate;

    if (govName == null && address.address.contains(' - ')) {
      final parts = address.address.split(' - ');
      if (getGovernorateIdByName(parts[0]) != null) {
        govName = parts[0];
      }
    }

    final govId = govName != null ? getGovernorateIdByName(govName) : null;

    _formStateNotifier.value = _formStateNotifier.value.copyWith(
      selectedAddress: address,
      isTemporaryAddress: false,
      clearGovernorate: true,
    );

    unawaited(context.read<CheckoutCubit>().getShippingFee(governorateId: govId));
  }

  void _selectTemporaryAddress(bool isTemporary) {
    if (!isTemporary) return;

    _formStateNotifier.value = _formStateNotifier.value.copyWith(isTemporaryAddress: true, clearSelectedAddress: true);

    final currentGov = _formStateNotifier.value.selectedGovernorate;
    if (currentGov != null) {
      final govId = getGovernorateIdByName(currentGov);
      unawaited(context.read<CheckoutCubit>().getShippingFee(governorateId: govId));
    } else {
      unawaited(context.read<CheckoutCubit>().getShippingFee());
    }
  }

  void _onGovernorateChanged(String? governorate) {
    if (governorate == null) return;

    _formStateNotifier.value = _formStateNotifier.value.copyWith(selectedGovernorate: governorate);

    final govId = getGovernorateIdByName(governorate);
    unawaited(context.read<CheckoutCubit>().getShippingFee(governorateId: govId));
  }

  String? _validateName(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return context.l10n.enter_full_name_validation_text;
    }
    if (trimmed.length < 3) {
      return context.l10n.name_too_short_text;
    }
    return null;
  }

  String? _validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return context.l10n.enter_phone_validation_text;
    }
    if (phone.length != 11 || !phone.startsWith('01')) {
      return context.l10n.invalid_phone_text;
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.select_or_enter_address_text;
    }
    return null;
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final formState = _formStateNotifier.value;

    final phoneError = _validatePhone(_phoneController.text);
    if (phoneError != null) {
      CustomSnackBar.show(context, phoneError);
      return;
    }

    var address = '';
    int? govId;

    if (formState.isTemporaryAddress) {
      final governorate = formState.selectedGovernorate;
      final city = _tempCityController.text.trim();
      final street = _tempStreetController.text.trim();

      if (governorate == null) {
        CustomSnackBar.show(context, 'Please select a governorate');
        return;
      }

      address = '$governorate - $city - $street';
      govId = getGovernorateIdByName(governorate);
    } else if (formState.selectedAddress != null) {
      final selectedAddress = formState.selectedAddress!;
      address = selectedAddress.address;

      var govName = selectedAddress.governorate;
      if (govName == null && address.contains(' - ')) {
        final parts = address.split(' - ');
        if (getGovernorateIdByName(parts[0]) != null) {
          govName = parts[0];
        }
      }
      if (govName != null) {
        govId = getGovernorateIdByName(govName);
      }
    } else {
      CustomSnackBar.show(context, context.l10n.select_or_enter_address_text);
      return;
    }

    var rawPhone = _phoneController.text.trim().replaceAll(' ', '');
    if (rawPhone.startsWith('0')) {
      rawPhone = rawPhone.substring(1);
    }
    final finalPhone = '+20$rawPhone';

    unawaited(
      context.read<CheckoutCubit>().checkout(
        userAddress: address,
        userName: _fullNameController.text.trim(),
        userPhone: finalPhone,
        governorateId: govId,
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _tempCityController.dispose();
    _tempStreetController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _formStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.cash_on_delivery_text), backgroundColor: context.colors.background),
    body: InternetStateManager(
      onRestoreInternetConnection: () {
        setState(() {
          _addressesFuture = _fetchAddresses();
        });
        _formStateNotifier.value = _formStateNotifier.value.copyWith(isLoadingShipping: true);
      },
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddressSection(context),
                SizedBox(height: 20.h),
                _buildContactSection(context),
                SizedBox(height: 20.h),
                _buildPriceSection(context),
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: _buildSubmitButton(context),
  );

  Widget _buildAddressSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.location_on_outlined, size: 20.r, color: context.colors.textPrimary),
          SizedBox(width: 8.w),
          Text(context.l10n.address_text, style: context.typography.titleMedium),
        ],
      ),
      SizedBox(height: 12.h),

      FutureBuilder<List<Address>>(
        future: _addressesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CustomLoadingIndicator());
          }

          final addresses = snapshot.data ?? [];

          return ValueListenableBuilder<_CheckoutFormState>(
            valueListenable: _formStateNotifier,
            builder: (context, formState, _) => RadioGroup<Object?>(
              groupValue: formState.isTemporaryAddress ? true : formState.selectedAddress,
              onChanged: (value) {
                if (value is Address) {
                  _selectAddress(value);
                } else if (value == true) {
                  _selectTemporaryAddress(true);
                }
              },
              child: Column(
                children: [
                  ...addresses.map(
                    (address) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _AddressRadioTile(
                        address: address,
                        isSelected: !formState.isTemporaryAddress && formState.selectedAddress == address,
                        onTap: () => _selectAddress(address),
                      ),
                    ),
                  ),

                  _TemporaryAddressRadioTile(
                    isSelected: formState.isTemporaryAddress,
                    onTap: () => _selectTemporaryAddress(true),
                  ),

                  if (formState.isTemporaryAddress)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: _TemporaryAddressForm(
                        selectedGovernorate: formState.selectedGovernorate,
                        onGovernorateChanged: _onGovernorateChanged,
                        cityController: _tempCityController,
                        streetController: _tempStreetController,
                        validator: _validateAddress,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );

  Widget _buildContactSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.person_outline, size: 20.r, color: context.colors.textPrimary),
          SizedBox(width: 8.w),
          Text(context.l10n.enter_full_name_text, style: context.typography.titleMedium),
        ],
      ),
      SizedBox(height: 12.h),
      CustomFormField(
        controller: _fullNameController,
        hint: context.l10n.enter_full_name_text,
        prefixIcon: Icon(Icons.person_outline, size: 20.r, color: context.colors.textSecondary),
        validator: _validateName,
      ),
      SizedBox(height: 12.h),
      CustomFormField(
        controller: _phoneController,
        hint: context.l10n.phone_number_text,
        prefixIcon: Icon(Icons.phone_outlined, size: 20.r, color: context.colors.textSecondary),
        validator: _validatePhone,
        keyboardType: TextInputType.phone,
      ),
    ],
  );

  Widget _buildPriceSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.receipt_long_outlined, size: 20.r, color: context.colors.textPrimary),
          SizedBox(width: 8.w),
          Text(context.l10n.prices_text, style: context.typography.titleMedium),
        ],
      ),
      SizedBox(height: 12.h),

      Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: context.radius.mdBorder,
          border: Border.all(color: context.colors.border),
        ),
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state.shippingFeeStatus == RequestStatus.success && state.shippingFee != null) {
              _formStateNotifier.value = _formStateNotifier.value.copyWith(
                shippingFee: state.shippingFee,
                isLoadingShipping: false,
              );
            } else if (state.shippingFeeStatus == RequestStatus.failure) {
              _formStateNotifier.value = _formStateNotifier.value.copyWith(isLoadingShipping: false);
            } else if (state.shippingFeeStatus == RequestStatus.loading) {
              _formStateNotifier.value = _formStateNotifier.value.copyWith(isLoadingShipping: true);
            }
          },
          builder: (context, state) => ValueListenableBuilder<_CheckoutFormState>(
            valueListenable: _formStateNotifier,
            builder: (context, formState, _) {
              final subtotal = double.tryParse(widget.totalPrice) ?? 0;
              final shipping = double.tryParse(formState.shippingFee) ?? 0;
              final total = subtotal + shipping;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.l10n.price_before_shipping_text, style: context.typography.body),
                      Text('${widget.totalPrice} ${context.l10n.egp_text}', style: context.typography.body),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.l10n.shipping_fee_text, style: context.typography.body),
                      if (formState.isLoadingShipping)
                        SizedBox(height: 18.r, width: 18.r, child: const CircularProgressIndicator(strokeWidth: 2))
                      else
                        Text('${formState.shippingFee} ${context.l10n.egp_text}', style: context.typography.body),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Divider(height: 1, color: context.colors.border),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.l10n.total_price_text, style: context.typography.titleMedium),
                      Text(
                        '${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 2)} ${context.l10n.egp_text}',
                        style: context.typography.titleMedium.copyWith(color: context.colors.secondary),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ],
  );

  Widget _buildSubmitButton(BuildContext context) => BlocConsumer<CheckoutCubit, CheckoutState>(
    listener: (context, state) {
      if (state.checkoutStatus == RequestStatus.success) {
        unawaited(getIt<CartCubit>().getCart());
        CustomSnackBar.show(context, state.message ?? '');
        Navigator.pop(context);
      } else if (state.checkoutStatus == RequestStatus.failure) {
        CustomSnackBar.show(context, state.errorMessage ?? context.l10n.error_occurred_text);
      }
    },
    builder: (context, state) {
      final isLoading = state.checkoutStatus == RequestStatus.loading;
      return SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 12.h, top: 6.h),
          child: CustomButton(
            text: isLoading ? const CustomLoadingIndicator() : Text(context.l10n.confirm_order_button_text),
            onPressed: isLoading ? null : _submitOrder,
          ),
        ),
      );
    },
  );
}

class _CheckoutFormState {
  const _CheckoutFormState({
    this.selectedAddress,
    this.isTemporaryAddress = false,
    this.selectedGovernorate,
    this.shippingFee = '0',
    this.isLoadingShipping = true,
  });
  final Address? selectedAddress;
  final bool isTemporaryAddress;
  final String? selectedGovernorate;
  final String shippingFee;
  final bool isLoadingShipping;

  _CheckoutFormState copyWith({
    Address? selectedAddress,
    bool? isTemporaryAddress,
    String? selectedGovernorate,
    String? shippingFee,
    bool? isLoadingShipping,
    bool clearSelectedAddress = false,
    bool clearGovernorate = false,
  }) => _CheckoutFormState(
    selectedAddress: clearSelectedAddress ? null : (selectedAddress ?? this.selectedAddress),
    isTemporaryAddress: isTemporaryAddress ?? this.isTemporaryAddress,
    selectedGovernorate: clearGovernorate ? null : (selectedGovernorate ?? this.selectedGovernorate),
    shippingFee: shippingFee ?? this.shippingFee,
    isLoadingShipping: isLoadingShipping ?? this.isLoadingShipping,
  );
}

class _AddressRadioTile extends StatelessWidget {
  const _AddressRadioTile({required this.address, required this.isSelected, required this.onTap});
  final Address address;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: context.radius.mdBorder,
    child: AnimatedContainer(
      duration: context.durations.fast,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isSelected ? context.colors.surfaceStrong : context.colors.surface,
        borderRadius: context.radius.mdBorder,
        border: Border.all(
          color: isSelected ? context.colors.primary : context.colors.border,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Radio<Address>(
            value: address,
            groupValue: isSelected ? address : null,
            onChanged: (_) => onTap(),
            activeColor: context.colors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.home_outlined, size: 16.r, color: context.colors.textSecondary),
                    SizedBox(width: 6.w),
                    Text(address.nameAddress, style: context.typography.body.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(address.address, style: context.typography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TemporaryAddressRadioTile extends StatelessWidget {
  const _TemporaryAddressRadioTile({required this.isSelected, required this.onTap});
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: context.radius.mdBorder,
    child: AnimatedContainer(
      duration: context.durations.fast,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isSelected ? context.colors.surfaceStrong : context.colors.surface,
        borderRadius: context.radius.mdBorder,
        border: Border.all(
          color: isSelected ? context.colors.primary : context.colors.border,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: isSelected ? true : null,
            onChanged: (_) => onTap(),
            activeColor: context.colors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.edit_location_alt_outlined, size: 16.r, color: context.colors.textSecondary),
                SizedBox(width: 6.w),
                Text(
                  context.l10n.temporary_address_text,
                  style: context.typography.body.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TemporaryAddressForm extends StatelessWidget {
  const _TemporaryAddressForm({
    required this.selectedGovernorate,
    required this.onGovernorateChanged,
    required this.cityController,
    required this.streetController,
    required this.validator,
  });
  final String? selectedGovernorate;
  final ValueChanged<String?> onGovernorateChanged;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: context.radius.mdBorder,
      border: Border.all(color: context.colors.border),
    ),
    child: Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedGovernorate,
          hint: Text(context.l10n.select_governorate_text, style: context.typography.bodySmall),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            filled: true,
            fillColor: context.colors.surface,
            border: OutlineInputBorder(
              borderRadius: context.radius.smBorder,
              borderSide: BorderSide(color: context.colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: context.radius.smBorder,
              borderSide: BorderSide(color: context.colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: context.radius.smBorder,
              borderSide: BorderSide(color: context.colors.primary, width: 1.5),
            ),
          ),
          dropdownColor: context.colors.surface,
          style: context.typography.body,
          items: egyptGovernoratesList
              .map((gov) => DropdownMenuItem<String>(value: gov.name, child: Text(gov.name)))
              .toList(),
          onChanged: onGovernorateChanged,
          validator: (value) => value == null || value.isEmpty ? context.l10n.required_text : null,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                controller: cityController,
                label: context.l10n.city_text,
                hint: context.l10n.city_text,
                prefixIcon: Icon(Icons.location_city_outlined, size: 18.r, color: context.colors.textSecondary),
                inputFormatters: [AddressFormatter()],
                validator: validator,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomFormField(
                controller: streetController,
                hint: context.l10n.enter_address_text,
                label: context.l10n.address_text,
                prefixIcon: Icon(Icons.home_outlined, size: 18.r, color: context.colors.textSecondary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.required_field_text;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
