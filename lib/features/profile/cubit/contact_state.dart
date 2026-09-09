part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

final class ContactInitial extends ContactState {
  const ContactInitial();
}

final class ContactLoading extends ContactState {
  const ContactLoading();
}

final class ContactLoaded extends ContactState {
  const ContactLoaded(this.contact);
  final ContactModel contact;

  @override
  List<Object?> get props => [contact];
}

final class ContactError extends ContactState {
  const ContactError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
