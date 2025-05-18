import 'package:flutter/material.dart';

class BrewRecipeDisplay extends StatefulWidget {
  const BrewRecipeDisplay({Key? key}) : super(key: key);

  @override
  _BrewRecipeDisplayState createState() => _BrewRecipeDisplayState();
}

class _BrewRecipeDisplayState extends State<BrewRecipeDisplay> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Brew Display"),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => print("Edit Brew"),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => print("Ow :3"),
              ),
            ],
          ),
          Stepper(
             controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            ElevatedButton(onPressed: details.onStepContinue, child: const Text('NEXT')),
            ElevatedButton(onPressed: details.onStepCancel, child: const Text('CANCEL')),
          ],
        );},
            currentStep: _currentStep,
            onStepContinue: _nextStep,
            onStepCancel: _prevStep,
            onStepTapped: (int step) {
              setState(() {
                _currentStep = step;
              });
            },
            steps: const [
              Step(title: Text("A"), content: Text("Provide info A")),
              Step(title: Text("B"), content: Text("Provide info based on A")),
              Step(title: Text("C"), content: Text("Provide info based on B")),
            ],
          ),
        ],
      ),
    );
  }
}
