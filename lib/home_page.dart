import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int totalConsume = 0;
  List<WaterTracker> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            'Total Consume',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            totalConsume.toString(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter number';
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int amount = int.tryParse(_controller.text) ?? 0;
                    totalConsume += amount;
                    WaterTracker waterTracker =
                        WaterTracker(amount, DateTime.now());
                    waterTrackList.add(waterTracker);
                    setState(() {
                    });
                  }

                  _controller.clear();
                  setState(() {});
                },
                child: const Text('Add'),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: waterTrackList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onLongPress: (){
                      totalConsume = totalConsume-waterTrackList[index].noOfGlass;
                      waterTrackList.removeAt(index);
                      setState(() {
                      });

                    },
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      DateFormat('HH:mm a        dd-MM-yyyy')
                          .format(waterTrackList[index].time),
                    ),
                    trailing: Text('${waterTrackList[index].noOfGlass}'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}

class WaterTracker {
  int noOfGlass;
  final DateTime time;

  WaterTracker(this.noOfGlass, this.time);
}
