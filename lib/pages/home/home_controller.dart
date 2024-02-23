import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController();
  // Define variables to hold user input and solution
  int jugXCapacity = 0;
  int jugYCapacity = 0;
  int targetVolume = 0;
  List<String> solutionStepsXToY = [];
  List<String> solutionStepsYToX = [];
  List<String> solution = [];
  TextEditingController xValue = TextEditingController();
  TextEditingController yValue = TextEditingController();
  TextEditingController zValue = TextEditingController();

  void solve({
    required final int jugXCapacity,
    required final int jugYCapacity,
    required final int targetVolume,
    required final BuildContext context,
  }) {
    var inverted = false;
    if (hasSolution(jugXCapacity, jugYCapacity, targetVolume)) {
      solution.clear();
      if (jugXCapacity < jugYCapacity) {
        inverted = false;
        fromSmallToBig(
          jugXCapacity,
          jugYCapacity,
          targetVolume,
          inverted: inverted,
        );
        fromBigToSmall(
          jugXCapacity,
          jugYCapacity,
          targetVolume,
          inverted: inverted,
        );
      } else if (jugXCapacity > jugYCapacity) {
        inverted = true;
        fromSmallToBig(
          jugYCapacity,
          jugXCapacity,
          targetVolume,
          inverted: inverted,
        );
        fromBigToSmall(
          jugYCapacity,
          jugXCapacity,
          targetVolume,
          inverted: inverted,
        );
      }
      if (solutionStepsXToY.isNotEmpty && solutionStepsYToX.isNotEmpty) {
        int xySize;
        int yxSize;
        xySize = solutionStepsXToY.length;
        yxSize = solutionStepsYToX.length;
        if (xySize < yxSize) {
          solution = solutionStepsXToY;
          notifyListeners();
        } else if (xySize > yxSize) {
          solution = solutionStepsYToX;
          notifyListeners();
        } else {
          solution = solutionStepsXToY;
          notifyListeners();
        }
      } else if (solutionStepsXToY.isNotEmpty && solutionStepsYToX.isEmpty) {
        solution = solutionStepsXToY;
        notifyListeners();
      } else if (solutionStepsXToY.isEmpty && solutionStepsYToX.isNotEmpty) {
        solution = solutionStepsYToX;
        notifyListeners();
      } else {
        // Case has passed previous verification and fall into the below
        // categories
        // 1) Case the jug surpasses the target volume
        // 2) Case the jug does not reach the target volume
        showSnackBar(context, 'No Solution');
        solution.clear();
        notifyListeners();
      }
    } else {
      showSnackBar(context, 'No Solution');
      solution.clear();
      notifyListeners();
    }
  }

  // From smallest number to largest number
  void fromSmallToBig(
    final int jugX,
    final int jugY,
    final int target, {
    required final bool inverted,
  }) {
    solutionStepsXToY.clear();
    var x = 0;
    var y = 0;
    while (y < target) {
      x = jugX;
      solutionStepsXToY.add('Fill bucket ${inverted ? 'y' : 'x'} ($x)');
      y = y + x;
      solutionStepsXToY.add(
        'Transfer from bucket ${inverted ? 'y' : 'x'} to bucket '
        '${inverted ? 'x' : 'y'} (${inverted ? 'x' : 'y'} = $y)',
      );
    }
    if (target == jugX || target == jugY) {
      solutionStepsXToY.removeLast();
    }
    if (y != target) {
      // Case the jug surpasses the target volume
      solutionStepsXToY.clear();
    }
  }

  // From largest number to smallest number
  void fromBigToSmall(
    final int jugX,
    final int jugY,
    final int target, {
    required final bool inverted,
  }) {
    solutionStepsYToX.clear();
    final x = jugX;
    var y = jugY;
    solutionStepsYToX.add('Fill bucket ${inverted ? 'x' : 'y'} ($y)');
    while (y > target) {
      y = y - x;
      solutionStepsYToX.add(
        'Transfer from bucket ${inverted ? 'x' : 'y'} to bucket '
        '${inverted ? 'y' : 'x'} (${inverted ? 'x' : 'y'} = $y)',
      );
      if (y > target) {
        solutionStepsYToX.add('Empty bucket ${inverted ? 'y' : 'x'}');
      }
    }
    if (y != target) {
      // Case the jug does not reach the target volume
      solutionStepsYToX.clear();
    }
  }

  // Function to calculate the greatest common divisor using Euclidean algorithm
  int gcd(final int a, final int b) {
    var tempA = a;
    var tempB = b;

    while (tempB != 0) {
      final remainder = tempA % tempB;
      tempA = tempB;
      tempB = remainder;
    }

    return tempA;
  }

  // Function to check if the Water Jug challenge has a solution
  bool hasSolution(
    final int jugX,
    final int jugY,
    final int target,
  ) {
    if (target > jugX && target > jugY) {
      return false;
    } else {
      return target % gcd(jugX, jugY) == 0;
    }
  }

  void showSnackBar(final BuildContext context, final String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
