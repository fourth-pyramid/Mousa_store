import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/profile/data/models/contact_model.dart';
import 'package:mousa_store/features/profile/domain/usecases/get_contact_info_use_case.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_bloc.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_event.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_state.dart';

class MockGetContactInfoUseCase extends Mock implements GetContactInfoUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetContactInfoUseCase mockGetContactInfoUseCase;

  setUp(() {
    mockGetContactInfoUseCase = MockGetContactInfoUseCase();
  });

  final sampleContact = ContactModel(
    email: 'support@mousastore.com',
    phone: '01000000000',
    whatsapp: '01000000000',
    facebook: 'https://facebook.com/mousa',
  );

  group('ContactBloc Tests', () {
    test('initial state is ContactInitial', () async {
      final bloc = ContactBloc(
        getContactInfoUseCase: mockGetContactInfoUseCase,
      );
      expect(bloc.state, isA<ContactInitial>());
      await bloc.close();
    });

    blocTest<ContactBloc, ContactState>(
      'ContactFetchRequested emits [ContactLoading, ContactLoaded] when succeeds',
      build: () {
        when(
          () => mockGetContactInfoUseCase(),
        ).thenAnswer((_) async => (data: sampleContact, error: null));
        return ContactBloc(getContactInfoUseCase: mockGetContactInfoUseCase);
      },
      act: (bloc) => bloc.add(const ContactFetchRequested()),
      expect: () => [isA<ContactLoading>(), isA<ContactLoaded>()],
    );

    blocTest<ContactBloc, ContactState>(
      'ContactFetchRequested emits [ContactLoading, ContactError] when fails',
      build: () {
        when(
          () => mockGetContactInfoUseCase(),
        ).thenAnswer((_) async => (data: null, error: 'Network error'));
        return ContactBloc(getContactInfoUseCase: mockGetContactInfoUseCase);
      },
      act: (bloc) => bloc.add(const ContactFetchRequested()),
      expect: () => [isA<ContactLoading>(), isA<ContactError>()],
    );
  });
}
