// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/inter.ttf
  String get inter => 'assets/fonts/inter.ttf';

  /// File path: assets/fonts/jet_brains.ttf
  String get jetBrains => 'assets/fonts/jet_brains.ttf';

  /// List of all assets
  List<String> get values => [inter, jetBrains];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Text.svg
  String get text => 'assets/icons/Text.svg';

  /// File path: assets/icons/biils.svg
  String get biils => 'assets/icons/biils.svg';

  /// File path: assets/icons/check.svg
  String get check => 'assets/icons/check.svg';

  /// File path: assets/icons/close.svg
  String get close => 'assets/icons/close.svg';

  /// File path: assets/icons/corp.svg
  String get corp => 'assets/icons/corp.svg';

  /// File path: assets/icons/dining.svg
  String get dining => 'assets/icons/dining.svg';

  /// File path: assets/icons/electricc.svg
  String get electricc => 'assets/icons/electricc.svg';

  /// File path: assets/icons/food.svg
  String get food => 'assets/icons/food.svg';

  /// File path: assets/icons/foods_market.svg
  String get foodsMarket => 'assets/icons/foods_market.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/home2.svg
  String get home2 => 'assets/icons/home2.svg';

  /// File path: assets/icons/menu.svg
  String get menu => 'assets/icons/menu.svg';

  /// File path: assets/icons/more.svg
  String get more => 'assets/icons/more.svg';

  /// File path: assets/icons/profile.svg
  String get profile => 'assets/icons/profile.svg';

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/shop.svg
  String get shop => 'assets/icons/shop.svg';

  /// File path: assets/icons/statistic.svg
  String get statistic => 'assets/icons/statistic.svg';

  /// File path: assets/icons/transit.svg
  String get transit => 'assets/icons/transit.svg';

  /// File path: assets/icons/wallet.svg
  String get wallet => 'assets/icons/wallet.svg';

  /// List of all assets
  List<String> get values => [
    text,
    biils,
    check,
    close,
    corp,
    dining,
    electricc,
    food,
    foodsMarket,
    home,
    home2,
    menu,
    more,
    profile,
    settings,
    shop,
    statistic,
    transit,
    wallet,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

abstract final class Assets {
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
