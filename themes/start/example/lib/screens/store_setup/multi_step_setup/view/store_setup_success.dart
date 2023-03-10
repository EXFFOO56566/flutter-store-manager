import 'package:example/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StoreSetupSuccessPage extends StatelessWidget with AppbarMixin {
  const StoreSetupSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: "Ready!",
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 38, 25, 25),
        child: StoreSetupSuccess(
          title: "We are done!",
          subtitle:
              "Your store is ready. It's time to experience the things more Easily and Peacefully. Add your products and start counting sales, have fun!!",
          button: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, HomePage.routeName);
            },
            child: const Text("Go To Dashboard"),
          ),
        ),
      ),
    );
  }
}
