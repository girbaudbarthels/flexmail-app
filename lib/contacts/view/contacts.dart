import 'package:flexmail_app/contacts/bloc/contact_bloc.dart';
import 'package:flexmail_app/core/data/flexmail_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactBloc(),
      child: const ContactView(),
    );
  }
}

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  @override
  void initState() {
    super.initState();
    print('InitState');
    context.read<ContactBloc>().add(ContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              print(state);
              if (state is LoadedContactState) {
                print(state.contactList);
                List contacts = state.contactList['_embedded']['item'] as List;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Contacts'),
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        'Contacten Toevoegen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                                '${state.contactList['_embedded']['item'][index]['email']}'),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
