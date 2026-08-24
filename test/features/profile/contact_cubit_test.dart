import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/profile/cubit/contact_cubit.dart';
import 'package:mousa_store/features/profile/model/contact_model.dart';
import 'package:mousa_store/features/profile/repo/contact_repo.dart';

class MockContactRepo extends Mock implements ContactRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockContactRepo mockContactRepo;

  setUp(() {
    mockContactRepo = MockContactRepo();
  });

  final sampleContact = ContactModel(
    email: 'support@mousastore.com',
    phone: '01000000000',
    whatsapp: '01000000000',
    facebook: 'https://facebook.com/mousa',
  );

  group('ContactCubit Tests', () {
    test('initial state is ContactInitial', () async {
      final cubit = ContactCubit(mockContactRepo);
      expect(cubit.state, isA<ContactInitial>());
      await cubit.close();
    });

    blocTest<ContactCubit, ContactState>(
      'getContactInfo emits [ContactLoading, ContactLoaded] when succeeds',
      build: () {
        when(() => mockContactRepo.getContactInfo()).thenAnswer(
          (_) async => (data: sampleContact, error: null),
        );
        return ContactCubit(mockContactRepo);
      },
      act: (cubit) => cubit.getContactInfo(),
      expect: () => [
        isA<ContactLoading>(),
        isA<ContactLoaded>(),
      ],
    );
  });
}
