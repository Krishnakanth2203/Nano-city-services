import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInputWidget extends StatefulWidget {
  final void Function(String) onOtpComplete;
  const CodeInputWidget({super.key, required this.onOtpComplete});

  @override
  State<CodeInputWidget> createState() => _CodeInputWidgetState();
}

class _CodeInputWidgetState extends State<CodeInputWidget> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void updateCode() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == 6) {
      widget.onOtpComplete(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'OTP Input Fields',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 45,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              maxLength: 1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < 5) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  } else {
                    _focusNodes[index].unfocus();
                  }
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
                updateCode();
              },
            ),
          );
        }),
      ),
    );
  }
}