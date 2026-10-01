import 'package:mousa_store/features/profile/data/datasources/contact_remote_data_source.dart';
import 'package:mousa_store/features/profile/data/models/contact_model.dart';
import 'package:mousa_store/features/profile/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl({
    required ContactRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ContactRemoteDataSource _remoteDataSource;

  @override
  Future<({String? error, ContactModel? data})> getContactInfo() =>
      _remoteDataSource.getContactInfo();
}
