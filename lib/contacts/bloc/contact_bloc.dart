import 'package:bloc/bloc.dart';
import 'package:flexmail_app/core/data/flexmail_api.dart';

enum LoadingContacts { loading }

class ContactState {}

class ContactsEvent {}

class ContactInitial extends ContactState {
  ContactInitial();
  List<Object>? get props => null;
}

class LoadedContactState extends ContactState {
  LoadedContactState(this.contactList);

  final Map<String, dynamic> contactList;

  List<Object> get props => [contactList];
}

class LoadContactsEvent extends ContactsEvent {
  List<Object>? get props => null;
}

class ContactBloc extends Bloc<ContactsEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<ContactsEvent>(getContacts);
  }
  Future<void> getContacts(ContactsEvent event, Emitter emit) async {
    final contactList = await FlexmailApi().getContacts();
    emit(LoadedContactState(contactList));
  }
}
