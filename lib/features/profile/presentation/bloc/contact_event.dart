import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_event.freezed.dart';

@freezed
sealed class ContactEvent with _$ContactEvent {
  const factory ContactEvent.fetchRequested() = ContactFetchRequested;
}
