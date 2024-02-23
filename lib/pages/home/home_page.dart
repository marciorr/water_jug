import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierProvider(
      create: (final _) {
        final myController = HomeController();
        return myController;
      },
      child: Consumer<HomeController>(
        builder: (final context, final controller, final _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Water Jug'),
            ),
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Text('Enter values:'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('X:'),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: controller.xValue,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Y:'),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: controller.yValue,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Z:'),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: controller.zValue,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.xValue.text.isNotEmpty &&
                            controller.yValue.text.isNotEmpty &&
                            controller.zValue.text.isNotEmpty) {
                          controller.solve(
                            jugXCapacity: int.parse(controller.xValue.text),
                            jugYCapacity: int.parse(controller.yValue.text),
                            targetVolume: int.parse(controller.zValue.text),
                            context: context,
                          );
                        } else {
                          controller.showSnackBar(
                            context,
                            'Please, enter all values!',
                          );
                        }
                      },
                      child: const Text('Solve'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Solution:'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.solution.length,
                        itemBuilder: (final context, final index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                Text('${index + 1}) '),
                                Text(controller.solution[index]),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
