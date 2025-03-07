import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_options.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/utils/images.dart';
import 'package:quickalert/widgets/quickalert_buttons.dart';

class QuickAlertContainer extends StatelessWidget {
  final QuickAlertOptions? options;

  const QuickAlertContainer({
    Key? key,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final header = buildHeader(context);
    final title = buildTitle(context);
    final text = buildText(context);
    final buttons = buildButtons();
    final widget = buildWidget(context);

    final content = Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          title,
          const SizedBox(
            height: 5.0,
          ),
          text,
          widget!,
          const SizedBox(
            height: 10.0,
          ),
          buttons
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: options!.backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(options!.borderRadius!),
      ),
      clipBehavior: Clip.antiAlias,
      width: options!.width ?? 390,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [header, content],
      ),
    );
  }

  Widget buildHeader(context) {
    String? anim = AppAnim.success;
    switch (options!.type) {
      case QuickAlertType.success:
        anim = AppAnim.success;
        break;
      case QuickAlertType.error:
        anim = AppAnim.error;
        break;
      case QuickAlertType.warning:
        anim = AppAnim.warning;
        break;
      case QuickAlertType.confirm:
        anim = AppAnim.confirm;
        break;
      case QuickAlertType.info:
        anim = AppAnim.info;
        break;
      case QuickAlertType.loading:
        anim = AppAnim.loading;
        break;
      default:
        anim = AppAnim.info;
        break;
    }

    if (options!.customAsset != null) {
      anim = options!.customAsset;
    }
    return Container(
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: Image.asset(
        anim ?? "",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildTitle(context) {
    final title = options!.title ?? whatTitle();
    return Visibility(
      visible: title != null,
      child: Text(
        '$title',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: options!.titleColor ?? Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget buildText(context) {
    if (options!.text == null && options!.type != QuickAlertType.loading) {
      return Container();
    } else {
      String? text = '';
      if (options!.type == QuickAlertType.loading) {
        text = options!.text ?? 'Loading';
      } else {
        text = options!.text;
      }
      return Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: options!.textColor ?? Theme.of(context).colorScheme.onSurface,
        ),
      );
    }
  }

  Widget? buildWidget(context) {
    if (options!.widget == null && options!.type != QuickAlertType.custom) {
      return Container();
    } else {
      Widget widget = Container();
      if (options!.type == QuickAlertType.custom) {
        widget = options!.widget ?? widget;
      }
      return options!.widget;
    }
  }

  Widget buildButtons() {
    if (options!.type == QuickAlertType.loading) {
      return Container();
    } else {
      return QuickAlertButtons(
        options: options,
      );
    }
  }

  String? whatTitle() {
    switch (options!.type) {
      case QuickAlertType.success:
        return 'Success';
      case QuickAlertType.error:
        return 'Error';
      case QuickAlertType.warning:
        return 'Warning';
      case QuickAlertType.confirm:
        return 'Are You Sure?';
      case QuickAlertType.info:
        return 'Info';
      case QuickAlertType.custom:
        return null;
      case QuickAlertType.loading:
        return null;
      default:
        return null;
    }
  }
}
