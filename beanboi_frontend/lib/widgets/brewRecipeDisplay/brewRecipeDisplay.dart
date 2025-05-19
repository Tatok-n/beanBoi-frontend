import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:flutter/material.dart';

class BrewRecipeDisplay extends StatefulWidget {
  BrewRecipeDisplay({Key? key}) : super(key: key);
  Userprefs userprefs = Userprefs();

  @override
  _BrewRecipeDisplayState createState() => _BrewRecipeDisplayState();
}

class _BrewRecipeDisplayState extends State<BrewRecipeDisplay> {
  int _currentStep = 0;
  double _currentRatioValue = 1;
  double _currentTemperatureSliderValue = 95;
  double _currentDurationSliderValue = 25;
  bool _isEspresso = true;
  int _numStages = 2;
  List<String> _stages = [];
  List<double> _stageValues = [];

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
            steps: [
              buildInfoStep(),
              buildStageStep(),
              Step(title: Text("C"), content: Text("Provide info based on B")),
            ],
          ),
        ],
      ),
    );
  }


  
Step buildInfoStep() {
  return Step(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Provide general information about the brew !"),
    ),
    content: Column(
      children: [
        SegmentedButton(
            onSelectionChanged: (newVal) {
              setState(() {
                _isEspresso = newVal.contains("espresso");
                if (!_isEspresso && _numStages == 1) {
                  _numStages = 2;
                }
              });
            },
            selected: {_isEspresso ? "espresso" : "v60"},
            segments: [
            ButtonSegment(value: "espresso", label: const Text("Espresso")),
            ButtonSegment(value: "v60", label: const Text("V60")),
          ],),
        buildInputField("Name"),
        buildInputField("Description"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child : Column(children: [  Text(
            "Ratio: $_currentRatioValue",
            style: widget.userprefs.inverseSurfaceTextS,
          ),buildSlider("Ratio", 0.5, 20, () {return _currentRatioValue;}, (double newValue) {
            setState(() {
              _currentRatioValue = newValue;
            });
          })],)
        ),
        Column(
          children: [
            Text(
            "Temp: $_currentTemperatureSliderValue",
            style: widget.userprefs.inverseSurfaceTextS,),
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: buildSlider("Temperature", 15, 100, () {return _currentTemperatureSliderValue;}, (double newValue) {
              setState(() {
                _currentTemperatureSliderValue = newValue;
              });
            }),
          )],
        ),
        Column(
          children: [
            Text(
            "Duration: $_currentDurationSliderValue",
            style: widget.userprefs.inverseSurfaceTextS,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: buildSlider("Duration", 5, 240, () {return _currentDurationSliderValue;},  (double newValue) {
                setState(() {
                  _currentDurationSliderValue = newValue;
                });
              }),
            ),
          ],
        ),
      ],
    ),
  );
}

Step buildStageStep() {
  return Step(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Text("Provide the number of stages in the brew !")),
      content : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Number of stages: $_numStages"),
          Padding(padding : const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FloatingActionButton( 
              onPressed: () {
                setState(() {
                  if (_numStages < 10) 
                  _numStages++;
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FloatingActionButton( 
              onPressed: () {
                setState(() {
                  int min = _isEspresso ? 1 : 2;
                  if (_numStages > min) 
                  _numStages--;
                });
              },
              child: const Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
}


Widget buildInputField(String label) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top : 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: TextField(
          onChanged: (String value) {
            },
          decoration: InputDecoration(
            labelStyle: Userprefs().inverseSurfaceTextS,
            labelText: label,
            border: const OutlineInputBorder(),
            
          ),
        ),
      ),
    ],
  );
}

Widget buildSlider(String label, double min, double max, getValue, setValue(double newValue)) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top : 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: Slider(
          value: getValue(),
          min: min,
          max: max,
          divisions: ((max - min).abs() * 10).toInt(),
          label: label,
          onChanged: (double newValue) {setValue(newValue);},
        ),
      ),
    ],
  );
}
}
