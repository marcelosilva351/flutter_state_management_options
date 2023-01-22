import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_options/bloc/bloc_home.dart';
import 'package:state_options/change_notifier_with_provider/chage_notifier_page.dart';
import 'package:state_options/change_notifier_with_provider/change_notifier_controller.dart';
import 'package:state_options/mobx/mobx_home.dart';
import 'package:state_options/set_state/home_set_state.dart';

void main() {
  runApp(const MaterialApp(
    home: SelectWidgetState(),
  ));
}

class SelectWidgetState extends StatelessWidget {
  const SelectWidgetState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select your state management"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeSetState()));
                },
                child: const Text("setState")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProviderChangeNotifier()));
                },
                child: const Text("ChageNotifier with provider")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MobxHome()));
                },
                child: const Text("MobX")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvierPage()));
                },
                child: const Text("Bloc"))
          ],
        ),
      ),
    );
  }
}
