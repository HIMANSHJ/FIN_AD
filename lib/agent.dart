import 'package:FinAd/agentform.dart';
import 'package:flutter/material.dart';

class AgentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Agent Form'),
          ),
          body: SignUpForm()),
    );
  }
}
