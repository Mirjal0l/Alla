import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  final String title;
  final String hint;
  const CustomField({
    required this.title,
    required this.hint,
    super.key
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late TextEditingController _controller;
  late FocusNode _focusNode; // for edit icon
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.hint);
    _focusNode = FocusNode();

    _focusNode.addListener(
        (){
          // when focus is lost, this will make it non-editable again
          if (!_focusNode.hasFocus) {
            setState(() {
              _isFocused = false;
            });
          }  
        }
    );
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

    Future.delayed(
      Duration.zero, (){
        _focusNode.requestFocus(); // requesting focus
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            child: CustomSubText(
              text: widget.title,
              size: 13,
              textAlign: TextAlign.start,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16), // Use width instead of height in Row
              // TextField with expanded to take remaining space
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.black2,
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    readOnly: !_isFocused,
                    enabled: true, // always unabled to receive focus
                    showCursor: _isFocused,// show cursor only when editable,
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          _enableEditing();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
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