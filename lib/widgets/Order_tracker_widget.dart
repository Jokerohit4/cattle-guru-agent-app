import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderTrackerWidget extends StatefulWidget {
  const OrderTrackerWidget({super.key});

  @override
  State<OrderTrackerWidget> createState() => _OrderTrackerWidgetState();
}

class _OrderTrackerWidgetState extends State<OrderTrackerWidget> {
  List<Step> _getSteps() {
  return [
    Step(
      title: Text('Order Placed'),
      content: Text('Your order has been placed successfully.'),
      subtitle: Text('March 20, 2023'),
    ),
    Step(
      title: Text('Order Confirmed'),
      content: Text('We have received your order and are processing it.'),
    ),
    Step(
      title: Text('Order Shipped'),
      content: Text('Your order has been shipped and is on its way to you.'),
    ),
    Step(
      title: Text('Order Delivered'),
      content: Text('Your order has been delivered to your address.'),
    ),
  ];
}
int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Stepper(
  steps: _getSteps(),
  currentStep: _currentStep,
  onStepContinue: () {
    setState(() {
      if (_currentStep < _getSteps().length - 1) {
        _currentStep++;
      } else {
        // reached the end
      }
    });
  },
);
  }
}