import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/profile/domain/usecases/get_contact_info_use_case.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_event.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc({required GetContactInfoUseCase getContactInfoUseCase})
      : _getContactInfoUseCase = getContactInfoUseCase,
        super(const ContactInitial()) {
    on<ContactFetchRequested>(_onContactFetchRequested);
  }

  final GetContactInfoUseCase _getContactInfoUseCase;

  Future<void> _onContactFetchRequested(
    ContactFetchRequested event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());
    try {
      final result = await _getContactInfoUseCase();
      if (result.error != null) {
        emit(ContactError(result.error!));
      } else if (result.data != null) {
        emit(ContactLoaded(result.data!));
      } else {
        emit(const ContactError('Unknown error'));
      }
    } on Object catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  // Compatibility helper
  Future<void> getContactInfo() async {
    add(const ContactFetchRequested());
  }
}
