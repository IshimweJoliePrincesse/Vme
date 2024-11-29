import 'package: flutter/material.dart';
import 'package: electa/view-model/counter_provider.dart';
import 'package: provider.provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override

  Widget build(BuildContext context){
    print('build');
    final counter_provider = Provider.of<CounterProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer<CounterProvider>(builder: (context, value, child){
              return Text(value.counter.toString());
            });
            Text('')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counter_provider.incrementCounter();
        },
      ),
    );
  }
}