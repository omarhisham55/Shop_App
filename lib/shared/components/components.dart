import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:toast/toast.dart';

double width(context, size) => MediaQuery.sizeOf(context).width * size;
double height(context, size) => MediaQuery.sizeOf(context).height * size;

Widget fallBackIndicator() => Center(child: CircularProgressIndicator());

enum ToastStates { success, warning, error }

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = ShopColors.successColor;
      break;
    case ToastStates.warning:
      color = ShopColors.warningColor;
      break;
    case ToastStates.error:
      color = ShopColors.errorColor;
      break;
  }
  return color;
}

void shopToast({required String text, required BuildContext context, required ToastStates state}) {
  ToastContext().context = context;
  return Toast.show(text, backgroundColor: toastColor(state));
}

void navigateTo(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void replacePage(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

Widget formTitle(context, text) => Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: ShopColors.darkColor),
    );
Widget formSubTitle(context, text) => Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: ShopColors.inActiveColor),
    );
Widget defaultTextFormField(
        {required BuildContext context,
        required TextEditingController controller,
        required String label,
        String? Function(String?)? validator,
        Function(String)? onSubmit,
        bool? isObscure,
        Widget? prefix,
        Widget? suffix,
        TextInputType? keyboardType}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isObscure ?? false,
      validator: validator,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
          label: Text(label, style: Theme.of(context).textTheme.labelSmall),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          prefixIcon: prefix,
          suffixIcon: suffix),
    );

Widget shopButton({
  required BuildContext context,
  required Function() onPressed,
  required String text,
  bool? isUpperCase,
  double? buttonWidth,
  double? borderRadius,
}) =>
    SizedBox(
      width: width(context, buttonWidth ?? 1),
      child: MaterialButton(
        onPressed: onPressed,
        color: ShopColors.defaultColor,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text((isUpperCase ?? false) ? text.toUpperCase() : text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ShopColors.whiteColor)),
        ),
      ),
    );

Widget selectionFormButton(text, function, buttonText) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(onPressed: function, child: Text(buttonText))
      ],
    );
