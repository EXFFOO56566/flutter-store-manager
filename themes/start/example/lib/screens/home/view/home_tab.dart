import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example/blocs/blocs.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => context.read<AuthCubit>().logoutAuth(),
                child: const Text('Logout'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => context.read<SettingCubit>().toggleBrightness(),
                child: const Text('Dark mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
