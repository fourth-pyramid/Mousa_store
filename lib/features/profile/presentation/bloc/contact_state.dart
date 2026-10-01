import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/profile/data/models/contact_model.dart';

part 'contact_state.freezed.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory ContactState.initial() = ContactInitial;
  const factory ContactState.loading() = ContactLoading;
  const factory ContactState.loaded(ContactModel contact) = ContactLoaded;
  const factory ContactState.error(String message) = ContactError;
}
