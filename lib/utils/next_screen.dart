import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

void nextScreen(context, page) {
  Navigator.of(context).push(SwipeablePageRoute(
    builder: (BuildContext context) => page,
  ));
}

void nextScreenReplace(context, page) {
  Navigator.of(context).pushReplacement(SwipeablePageRoute(
    builder: (BuildContext context) => page,
  ));
}
