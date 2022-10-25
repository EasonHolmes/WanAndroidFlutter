import 'dart:ffi';

import 'package:flutter/material.dart';

class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return FittedBox(
          //空间适配 自动缩放
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minWidth: constraints.maxWidth,
              maxWidth: double.infinity,
              //maxWidth: constraints.maxWidth
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final String text;
  final double textSize;
  final VoidCallback? onPressed;
  final double? width;

  final double? height;

  const CustomButton(this.text,
      {super.key,
      required this.onPressed,
      this.bgColor,
      this.textColor,
      this.width,
      this.height,
      required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Ink(
          decoration: BoxDecoration(
              color: bgColor ?? Colors.blue, //按钮颜色
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: const [
                //阴影
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 4.0)
              ]),
          child: InkWell(
            onTap: onPressed,
            // splashColor: Colors.red, //自定义水波纹颜色，不设置则是白色
            //圆角设置,给水波纹也设置同样的圆角
            //如果这里不设置就会出现矩形的水波纹效果
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 15, top: 10, right: 15, bottom: 10),
              child: Text(
                text,
                style: TextStyle(
                    color: textColor ?? Colors.white, fontSize: textSize),
              ),
            ),
          ),
        ));
  }
}

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    required this.onPressed,
    this.child,
    this.bgColor,
    this.radius,
  });

  final Color? bgColor;
  final VoidCallback? onPressed;
  final Widget? child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        //     boxShadow: const [
        //   //阴影
        //   BoxShadow(
        //       color: Colors.black26, offset: Offset(4.0, 4.0), blurRadius: 4.0)
        // ]
      ),
      child: InkWell(
          // splashColor: Colors.red, //自定义水波纹颜色，不设置则是白色
          borderRadius: BorderRadius.circular(radius ?? 0),
          onTap: onPressed,
          child: child),
    );
  }
}

class ChangeLineText extends StatelessWidget {
  final String text;

  const ChangeLineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [Text(text)],
          ),
        ),
      ],
    );
  }
}
