import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/brewRecipeDisplay/brewRecipeChart.dart';

class ChartTestApp extends StatelessWidget {
  const ChartTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew Recipe Chart Test',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChartTestPage(),
    );
  }
}

class ChartTestPage extends StatefulWidget {
  const ChartTestPage({Key? key}) : super(key: key);

  @override
  _ChartTestPageState createState() => _ChartTestPageState();
}

class _ChartTestPageState extends State<ChartTestPage> {
  double _ratio = 1.5;
  double _temperature = 92.0;
  double _duration = 30.0;
  int _numStages = 3;
  bool _isEspresso = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brew Recipe Chart Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recipe Parameters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Brewing Method: '),
                        Switch(
                          value: _isEspresso,
                          onChanged: (value) {
                            setState(() {
                              _isEspresso = value;
                            });
                          },
                        ),
                        Text(_isEspresso ? 'Espresso' : 'V60'),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text('Ratio: ${_ratio.toStringAsFixed(1)}'),
                    Slider(
                      value: _ratio,
                      min: 0.5,
                      max: 20.0,
                      divisions: 195,
                      onChanged: (value) {
                        setState(() {
                          _ratio = value;
                        });
                      },
                    ),
                    
                    Text('Temperature: ${_temperature.toStringAsFixed(1)}°C'),
                    Slider(
                      value: _temperature,
                      min: 60.0,
                      max: 100.0,
                      divisions: 40,
                      onChanged: (value) {
                        setState(() {
                          _temperature = value;
                        });
                      },
                    ),
                    
                    Text('Duration: ${_duration.toStringAsFixed(1)}s'),
                    Slider(
                      value: _duration,
                      min: 5.0,
                      max: 240.0,
                      divisions: 235,
                      onChanged: (value) {
                        setState(() {
                          _duration = value;
                        });
                      },
                    ),
                    
                    Row(
                      children: [
                        const Text('Stages: '),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _numStages > 1 ? () {
                            setState(() {
                              _numStages--;
                            });
                          } : null,
                        ),
                        Text('$_numStages'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _numStages < 10 ? () {
                            setState(() {
                              _numStages++;
                            });
                          } : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Chart
            const Text(
              'Recipe Visualization',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            BrewRecipeChart(
              ratio: _ratio,
              temperature: _temperature,
              duration: _duration,
              numStages: _numStages,
              isEspresso: _isEspresso,
            ),
          ],
        ),
      ),
    );
  }
}