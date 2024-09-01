import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../../config/color.dart';

class CheckFormSerial extends StatefulWidget {
  final bool isOtherFieldFilled;
  final Function(bool) onFieldFilled;
  final TextEditingController controller;
  final FormFieldValidator<String?>? validator;

  

  const CheckFormSerial(
      {Key? key,
      required this.isOtherFieldFilled,
      required this.onFieldFilled,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  _CheckFormSerialState createState() => _CheckFormSerialState();
}

class _CheckFormSerialState extends State<CheckFormSerial> {
  bool _isFocused = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    widget.onFieldFilled(widget.controller.text.isNotEmpty);
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.dispose();
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
            color: _isFocused || widget.controller.text.isNotEmpty
                ? AppColors.primary
                : AppColors.backgroudColor,
            child: Text(
              LocaleKeys.useSerial.tr,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            LocaleKeys.serial16To20.tr,
            style: const TextStyle(color: AppColors.text, fontSize: 12.0),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.serialCannotBeEmpty.tr;
              }
              if (value.length < 16 || value.length > 20) {
                return LocaleKeys.serial16To20.tr;
              }
              return null;
            },
            onChanged: (value) {
              String newValue = value.replaceAll('-', '');
              if (newValue.length > 4) {
                newValue = newValue.replaceAllMapped(
                    RegExp(r'.{4}'), (match) => '${match.group(0)}-');
                if (newValue.endsWith('-')) {
                  newValue = newValue.substring(0, newValue.length - 1);
                }
              }
              widget.controller.value = TextEditingValue(
                text: newValue,
                selection: TextSelection.collapsed(offset: newValue.length),
              );
              widget.controller.text = newValue;
            },
            decoration: InputDecoration(
              hintText: 'XXXX-XXXX-XXXX-XXXX',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
