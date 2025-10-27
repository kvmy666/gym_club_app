import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(leading: Icon(Icons.person), title: Text('Your Profile')),
          const Divider(),
          const ListTile(leading: Icon(Icons.card_membership), title: Text('Membership')),
          const ListTile(leading: Icon(Icons.qr_code), title: Text('Digital Check-In')),
          const ListTile(leading: Icon(Icons.support_agent), title: Text('Support')),
          const ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Sign in / Create account'),
            onTap: () => context.go('/auth/sign-in'),
          ),
        ],
      ),
    );
  }
}
