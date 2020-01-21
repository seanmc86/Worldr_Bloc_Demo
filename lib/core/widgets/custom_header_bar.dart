import 'package:flutter/material.dart';

class CustomHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeaderBar(
      {Key key,
      this.titleBar,
      this.leading,
      this.showBorder = false,
      this.color = Colors.white,
      this.borderColor = Colors.grey,
      this.padding,
      this.animation})
      : super(key: key);

  final Widget titleBar;
  final Widget leading;
  final bool showBorder;
  final Color color;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final Animation<Offset> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Transform.translate(
              offset: animation.value,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          padding ?? const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: color,
                        border: showBorder != true
                            ? null
                            : Border(
                                bottom: BorderSide(
                                  color: borderColor,
                                ),
                              ),
                      ),
                      child: Row(
                        children: <Widget>[
                          if (leading != null) leading,
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: titleBar ?? Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  AppBarDelegate({@required this.child}) : assert(child != null);

  final Widget child;
  final double height = 80;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;
}
