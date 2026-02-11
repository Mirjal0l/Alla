import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final bool? isPhoneNumber;

  const CustomField({
    required this.title,
    required this.hint,
    this.controller,
    this.onSubmitted,
    required this.isPhoneNumber,
    super.key
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late TextEditingController _controller;
  late FocusNode _focusNode; // for edit icon
  bool _isFocused = false;

  void _submitText() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(_controller.text);
    }
    setState(() {
      _isFocused = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.hint);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      // when focus is lost, submit the text
      if (!_focusNode.hasFocus && _isFocused) {
        _submitText();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _enableEditing() {
    setState(() {
      _isFocused = true;
    });

    // Request a focus after tiny delay for making sure set state updated

    Future.delayed(Duration.zero, () {
      _focusNode.requestFocus(); // requesting focus
    });
  }
  var phoneMask2 = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppUtils.kPaddingHor16,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // padding: EdgeInsets.only(left: 16),
            child: CustomSubText(
              text: widget.title,
              size: 13,
              textAlign: TextAlign.start,
            ),
          ),

          AppUtils.kGap8,

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppUtils.kBorderRadius12,
                    color: AppColors.black2,
                  ),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      _submitText();
                    },
                    focusNode: _focusNode,
                    readOnly: _isFocused,
                    inputFormatters: widget.isPhoneNumber == true ? [phoneMask2] : null,
                    keyboardType: widget.isPhoneNumber == true ? TextInputType.phone : TextInputType.text,
                    enabled: true,
                    // always unabled to receive focus
                    showCursor: !_isFocused,
                    // show cursor only when editable,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: AppUtils.kPaddingAll16,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if(_isFocused) {
                            _submitText();
                          } else {
                            _enableEditing();
                          }
                        },
                        child: Padding(
                          padding: AppUtils.kPaddingAll12,
                          child: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
