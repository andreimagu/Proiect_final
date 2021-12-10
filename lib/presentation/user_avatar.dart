import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tema5/actions/index.dart';
import 'package:tema5/container/user_container.dart';
import 'package:tema5/models/index.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        if (user == null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(Icons.person),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              StoreProvider.of<AppAction>(context).dispatch(const SignOut());
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(user.username[0].toUpperCase()),
            ),
          ),
        );
      },
    );
  }
}
