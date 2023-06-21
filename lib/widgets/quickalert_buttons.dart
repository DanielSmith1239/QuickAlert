import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_options.dart';
import 'package:quickalert/models/quickalert_type.dart';

class QuickAlertButtons extends StatelessWidget {
  final QuickAlertOptions? options;

  const QuickAlertButtons({
    Key? key,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          cancelBtn(context),
          okayBtn(context),
        ],
      ),
    );
  }

  Widget okayBtn(BuildContext context) {
    final showCancelBtn = options!.type == QuickAlertType.confirm
        ? true
        : options!.showCancelBtn!;

    final okayBtn = buildButton(
      context: context,
      isOkayBtn: true,
      text: options!.confirmBtnText!,
      onTap: options!.onConfirmBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: okayBtn);
    } else {
      return okayBtn;
    }
  }

  Widget cancelBtn(BuildContext context) {
    final showCancelBtn = options!.type == QuickAlertType.confirm
        ? true
        : options!.showCancelBtn!;

    final cancelBtn = buildButton(
      context: context,
      isOkayBtn: false,
      text: options!.cancelBtnText!,
      onTap: options!.onCancelBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: cancelBtn);
    } else {
      return Container();
    }
  }

  Widget buildButton({
    required BuildContext context,
    required bool isOkayBtn,
    required String text,
    VoidCallback? onTap,
  }) {
    final btnText = Text(
      text,
      style: defaultTextStyle(isOkayBtn, context),
    );

    final okayBtn = TextButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
        // color: options!.confirmBtnColor ?? Theme.of(context!).primaryColor,
        onPressed: onTap,
        style: TextButton.styleFrom(
            backgroundColor: options!.confirmBtnColor ??
                Theme.of(context).colorScheme.primaryContainer,
            textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
        child: btnText);

    final cancelBtn = GestureDetector(
      onTap: onTap,
      child: Center(
        child: btnText,
      ),
    );

    return isOkayBtn ? okayBtn : cancelBtn;
  }

  TextStyle defaultTextStyle(bool isOkayBtn, BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer);

    if (isOkayBtn) {
      return textStyle!.merge(options!.confirmBtnTextStyle);
    } else {
      return textStyle!.merge(options!.cancelBtnTextStyle);
    }
  }
}
