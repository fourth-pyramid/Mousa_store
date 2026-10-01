import 'package:mousa_store/features/profile/data/models/contact_model.dart';

abstract interface class ContactRepository {
  Future<({String? error, ContactModel? data})> getContactInfo();
}
