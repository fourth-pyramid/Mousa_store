import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/profile/model/contact_model.dart';
import 'package:mousa_store/features/profile/repo/contact_repo.dart';

part 'contact_state.dart';

class ContactCubit extends SafeCubit<ContactState> {
  ContactCubit(this.contactRepo) : super(const ContactInitial());
  final ContactRepo contactRepo;

  Future<void> getContactInfo() async {
    emit(const ContactLoading());
    final result = await contactRepo.getContactInfo();
    if (result.error != null) {
      emit(ContactError(result.error!));
    } else if (result.data != null) {
      emit(ContactLoaded(result.data!));
    }
  }
}
