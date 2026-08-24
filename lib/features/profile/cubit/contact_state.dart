part of 'contact_cubit.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  ContactLoaded(this.contact);
  final ContactModel contact;
}

class ContactError extends ContactState {
  ContactError(this.message);
  final String message;
}
