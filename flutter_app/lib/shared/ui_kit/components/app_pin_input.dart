import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// PIN-код инпут из 6 отдельных полей
class AppPinCodeInput extends StatefulWidget {
  const AppPinCodeInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.errorText,
  });

  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  State<AppPinCodeInput> createState() => _AppPinCodeInputState();
}

class _AppPinCodeInputState extends State<AppPinCodeInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final List<String> _previousValues;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _previousValues = List.generate(widget.length, (_) => '');
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(final String value, final int index) {
    final previousValue = _previousValues[index];

    _previousValues[index] = value;

    if (value.isNotEmpty && previousValue.isEmpty) {
      // ввели новую цифру - переходим к следующему полю
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // убрать фокус на ласт поле
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && previousValue.isNotEmpty) {
      // переход к предыдущему полю
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    _updatePin();
  }

  bool _onKeyEvent(final KeyEvent event, final int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      // если поле пустое и нажали backspace, переходим к предыдущему
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
        // очистка старого
        _controllers[index - 1].clear();
        _previousValues[index - 1] = '';
        _updatePin();
        return true;
      }
    }
    return false; // не обрабатываем событие
  }

  void _updatePin() {
    final pin = _controllers.map((final controller) => controller.text).join();

    widget.onChanged?.call(pin);

    if (pin.length == widget.length) {
      widget.onCompleted?.call(pin);
    }
  }

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.length,
          (final index) => SizedBox(
            width: 48,
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (final event) {
                _onKeyEvent(event, index);
              },
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (final value) => _onChanged(value, index),
                onTap: () {
                  // при нажатии на поле выделять всё содержимое
                  _controllers[index].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _controllers[index].text.length,
                  );
                },
                decoration: InputDecoration(
                  counterText: '', // Убираем счетчик символов
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.errorText != null
                          ? AppColors.error
                          : AppColors.border,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.errorText != null
                          ? AppColors.error
                          : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.errorText != null
                          ? AppColors.error
                          : AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (widget.errorText != null) ...[
        const SizedBox(height: 8),
        Text(
          widget.errorText!,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
        ),
      ],
    ],
  );
}
