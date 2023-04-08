import 'package:flutter/material.dart';

class SizeConfig {

  BuildContext ctx;
  MediaQueryData? _mediaQueryData;
  double? screenWidth;
  double? screenHeight;
  // final Double? defaultSize;
  Orientation? orientation;
  
  SizeConfig(this.ctx) {
    _mediaQueryData = MediaQuery.of(ctx);
    screenHeight = _mediaQueryData?.size.height;
    screenWidth = _mediaQueryData?.size.width;
    orientation = _mediaQueryData?.orientation;
    
  }

  // Get the proportionate height as per screen size
  double getProportionateScreenHeight(double inputHeight) {
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight!;
  }

  // Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth!;
  }

  double getProportionatePadding(double inputWidth)
  {
    return screenWidth! * 0.025;
  }
   double getProportionateroundess()
  {
    return screenWidth! * 0.02;
  }
}