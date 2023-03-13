import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming/providers/example_one_provider.dart';

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> {
  @override
  Widget build(BuildContext context) {
    print('build');
    final provider = Provider.of<ExampleOneProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Opacity Slider')),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Consumer<ExampleOneProvider>(builder: ((context, value, child) {
          return Slider(
              min: 0,
              max: 1.0,
              value: value.valu,
              onChanged: (val) {
                value.setValue(val);
              });
        })),
        const SizedBox(
          height: 20,
        ),
        Consumer<ExampleOneProvider>(builder: ((context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 100,
                  color: const Color.fromARGB(255, 205, 33, 235)
                      .withOpacity(value.valu),
                  child: const Center(child: Text('Container 1')),
                )),
                Expanded(
                    child: Container(
                  height: 100,
                  color: const Color.fromARGB(255, 219, 219, 29)
                      .withOpacity(value.valu),
                  child: const Center(child: Text('Container 2')),
                )),
              ],
            ),
          );
        }))
      ]),
    );
  }
}
