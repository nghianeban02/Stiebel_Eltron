import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../../config/color.dart';

class CheckFormPhone extends StatefulWidget {
  final bool isOtherFieldFilled;
  final Function(bool) onFieldFilled;
  final TextEditingController controller;
  final FormFieldValidator<String?>? validator;


  const CheckFormPhone({Key? key, required this.isOtherFieldFilled, required this.onFieldFilled, required this.controller,required this.validator}) : super(key: key);

  @override
  _CheckFormPhoneState createState() => _CheckFormPhoneState();
}

class _CheckFormPhoneState extends State<CheckFormPhone> {
  bool _isFocused = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    widget.onFieldFilled(_controller.text.isNotEmpty);
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroudWhite,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: _isFocused || _controller.text.isNotEmpty
                ? AppColors.primary
                : AppColors.backgroudColor,
            child:  Text(
              LocaleKeys.usePhone.tr,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
              hintText: LocaleKeys.activationPhoneNumber.tr,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: AppColors.text),
            enabled: !widget.isOtherFieldFilled,
          ),
        ],
      ),
    );
  }
}
