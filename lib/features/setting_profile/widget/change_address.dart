import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/governorates_data.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/setting_profile/model/address_model.dart';
import 'package:mousa_store/features/setting_profile/widget/add_new_address.dart';

final List<String> egyptGovernorates = egyptGovernoratesList
    .map((e) => e.name)
    .toList();

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  late final ValueNotifier<Future<List<Address>>> _addressesNotifier;

  List<String> governorates = egyptGovernorates;
  bool isGovernoratesLoading = false;

  @override
  void initState() {
    super.initState();
    _addressesNotifier = ValueNotifier(fetchAddresses());
  }

  @override
  void dispose() {
    _addressesNotifier.dispose();
    super.dispose();
  }

  Future<List<Address>> fetchAddresses() async {
    try {
      final response = await DioHelper.getData(url: 'address');
      final data = response.data as Map<String, dynamic>;
      final innerData = data['data'] as Map<String, dynamic>;
      final listData = innerData['data'] as List<dynamic>;
      return listData
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      return [];
    }
  }

  Future<bool> createAddress({
    required String nameAddress,
    required String address,
    required String governorate,
  }) async {
    try {
      await DioHelper.postData(
        url: 'address/create',
        data: {
          'name_address': nameAddress,
          'address': address,
          'governorate': governorate,
        },
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateAddress({
    required int id,
    required String nameAddress,
    required String address,
    required String governorate,
  }) async {
    try {
      await DioHelper.putData(
        url: 'address/update',
        data: {
          'address_id': id.toString(),
          'name_address': nameAddress,
          'address': address,
          'governorate': governorate,
        },
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> deleteAddress(int id) async {
    try {
      await DioHelper.deleteData(url: 'address/delete/$id');
      return true;
    } on Exception {
      return false;
    }
  }

  void _refreshAddresses() {
    _addressesNotifier.value = fetchAddresses();
  }

  void _confirmDeleteAddress(Address address) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.delete_address_title_text),
          content: Text(
            '${context.l10n.delete_confirmation_message_text} "${address.nameAddress}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.cancel_text),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final success = await deleteAddress(address.id);
                if (success) _refreshAddresses();
              },
              child: Text(context.l10n.delete_text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final result = await navigateWithTransition<bool>(
          context,
          const AddNewAddress(),
          type: TransitionType.fade,
        );
        if (result ?? false) {
          _refreshAddresses();
        }
      },
      child: const Icon(Icons.add),
    ),
    appBar: AppBar(title: Text(context.l10n.your_addresses_text)),
    body: InternetStateManager(
      onRestoreInternetConnection: _refreshAddresses,
      child: ValueListenableBuilder<Future<List<Address>>>(
        valueListenable: _addressesNotifier,
        builder: (context, future, _) => FutureBuilder<List<Address>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return AppEmptyState(
                title: context.l10n.no_addresses_yet_text,
                icon: Icons.location_off_outlined,
              );
            }

            final addresses = snapshot.data!;
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Dismissible(
                  key: Key(address.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: ColoredBox(
                      color: context.colors.error,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 20.w,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: context.colors.onError,
                          ),
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (_) async {
                    _confirmDeleteAddress(address);
                    return false;
                  },
                  child: Card(
                    color: context.colors.surface,
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          size: 30.w,
                          color: context.colors.primary,
                        ),
                        title: Text(
                          address.nameAddress,
                          style: context.typography.titleMedium,
                        ),
                        subtitle: Text(
                          address.address,
                          style: context.typography.body,
                        ),
                        onTap: () async {
                          final result = await navigateWithTransition<bool>(
                            context,
                            AddNewAddress(address: address),
                            type: TransitionType.fade,
                          );
                          if (result ?? false) {
                            _refreshAddresses();
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
