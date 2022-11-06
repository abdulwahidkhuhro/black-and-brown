import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:black_n_brown/constants/constants.dart';
import '../providers/orders.dart';

class CustomButton extends StatefulWidget {
  String label;
  Function add;
  CustomButton({required this.label, required this.add});
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  var _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        child: SizedBox(
          width: widget.label.length * 2 + 80,
          height: 22,
          child: _showSpinner
              ? const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(color: kWhite),
                  ),
                )
              : Text(widget.label, textAlign: TextAlign.center),
        ),
        onPressed: () {
          setState(() {
            _showSpinner = true;
          });
          widget.add().then((_) {
            setState(() {
              _showSpinner = false;
            });
          });
        },
      ),
    );
  }
}
