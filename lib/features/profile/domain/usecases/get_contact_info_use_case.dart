import 'package:mousa_store/features/profile/data/models/contact_model.dart';
import 'package:mousa_store/features/profile/domain/repositories/contact_repository.dart';

class GetContactInfoUseCase {
  const GetContactInfoUseCase(this._repository);

  final ContactRepository _repository;

  Future<({String? error, ContactModel? data})> call() =>
      _repository.getContactInfo();
}
