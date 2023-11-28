import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:owl/owl.dart';

class Responsive extends HookWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * ResponsiveTwoColumnLayout

        CardOrganize(
          'ResponsiveTwoColumnLayout',
          ResponsiveTwoColumnLayout(
            startContent: Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
            ),
            endContent: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'World',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
            ),
          ),
        ),

        // * ResponsiveCenter

        CardOrganize(
          'ResponsiveCenter',
          ResponsiveCenter(
            // Make it same as ResponsiveTwoColumnLayout for example
            maxContentWidth: 800,
            child: Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
