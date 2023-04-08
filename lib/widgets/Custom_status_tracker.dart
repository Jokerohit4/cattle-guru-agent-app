import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:flutter/material.dart';

class MyStatusTracker extends StatefulWidget {
  @override
  _MyStatusTrackerState createState() => _MyStatusTrackerState();
}

class _MyStatusTrackerState extends State<MyStatusTracker> {
  int _currentStep = 0;

  List<Step> _steps = [
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              orderconfirmed,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Order Confirmed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.indexed,
      content: SizedBox(height: 0),
    ),
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              orderinprogress,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Order in Progress",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.complete,
      content: SizedBox(height: 0),
    ),
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              orderdeliverd,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Order Delivered",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.complete,
      content: SizedBox(height: 0),
    ),
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              earningsrecived,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Order Earnings Received",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.complete,
      content: SizedBox(height: 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: _steps,
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (value) {
        setState(() {
          if (_currentStep < _steps.length - 1) {
            _currentStep++;
          }
        });
      },
      onStepContinue: () {
        setState(() {
          if (_currentStep < _steps.length - 1) {
            _currentStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep--;
          }
        });
      },
      controlsBuilder: (context, details) {
        return Container();
      },
    );
  }
}
