import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff89511f),
      surfaceTint: Color(0xff89511f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcc3),
      onPrimaryContainer: Color(0xff6c3a08),
      secondary: Color(0xff31628d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe5ff),
      onSecondaryContainer: Color(0xff114a73),
      tertiary: Color(0xff5d6236),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe2e7b0),
      onTertiaryContainer: Color(0xff454a21),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff221a14),
      onSurfaceVariant: Color(0xff51443b),
      outline: Color(0xff847469),
      outlineVariant: Color(0xffd6c3b7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77f),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77f),
      onPrimaryFixedVariant: Color(0xff6c3a08),
      secondaryFixed: Color(0xffcfe5ff),
      onSecondaryFixed: Color(0xff001d33),
      secondaryFixedDim: Color(0xff9ccbfb),
      onSecondaryFixedVariant: Color(0xff114a73),
      tertiaryFixed: Color(0xffe2e7b0),
      onTertiaryFixed: Color(0xff1a1e00),
      tertiaryFixedDim: Color(0xffc6cb96),
      onTertiaryFixedVariant: Color(0xff454a21),
      surfaceDim: Color(0xffe7d7ce),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfffbebe1),
      surfaceContainerHigh: Color(0xfff5e5db),
      surfaceContainerHighest: Color(0xffefdfd6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff562b00),
      surfaceTint: Color(0xff89511f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9a5f2c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00395d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff41719c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff343912),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c7043),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff17100a),
      onSurfaceVariant: Color(0xff40342b),
      outline: Color(0xff5e5046),
      outlineVariant: Color(0xff796a60),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77f),
      primaryFixed: Color(0xff9a5f2c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7d4716),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff41719c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff255882),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c7043),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff53582d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3c4ba),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfff5e5db),
      surfaceContainerHigh: Color(0xffeadad0),
      surfaceContainerHighest: Color(0xffdecfc5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff472200),
      surfaceTint: Color(0xff89511f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6f3c0a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002e4e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff154c76),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2a2f08),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff474c23),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff352a21),
      outlineVariant: Color(0xff54473d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77f),
      primaryFixed: Color(0xff6f3c0a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff512800),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff154c76),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003558),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff474c23),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff31350e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5b6ad),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffeeee4),
      surfaceContainer: Color(0xffefdfd6),
      surfaceContainerHigh: Color(0xffe1d1c8),
      surfaceContainerHighest: Color(0xffd3c4ba),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb77f),
      surfaceTint: Color(0xffffb77f),
      onPrimary: Color(0xff4e2600),
      primaryContainer: Color(0xff6c3a08),
      onPrimaryContainer: Color(0xffffdcc3),
      secondary: Color(0xff9ccbfb),
      onSecondary: Color(0xff003354),
      secondaryContainer: Color(0xff114a73),
      onSecondaryContainer: Color(0xffcfe5ff),
      tertiary: Color(0xffc6cb96),
      onTertiary: Color(0xff2f330c),
      tertiaryContainer: Color(0xff454a21),
      onTertiaryContainer: Color(0xffe2e7b0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff19120c),
      onSurface: Color(0xffefdfd6),
      onSurfaceVariant: Color(0xffd6c3b7),
      outline: Color(0xff9e8d82),
      outlineVariant: Color(0xff51443b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefdfd6),
      inversePrimary: Color(0xff89511f),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77f),
      onPrimaryFixedVariant: Color(0xff6c3a08),
      secondaryFixed: Color(0xffcfe5ff),
      onSecondaryFixed: Color(0xff001d33),
      secondaryFixedDim: Color(0xff9ccbfb),
      onSecondaryFixedVariant: Color(0xff114a73),
      tertiaryFixed: Color(0xffe2e7b0),
      onTertiaryFixed: Color(0xff1a1e00),
      tertiaryFixedDim: Color(0xffc6cb96),
      onTertiaryFixedVariant: Color(0xff454a21),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff312822),
      surfaceContainerHighest: Color(0xff3c332d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd4b5),
      surfaceTint: Color(0xffffb77f),
      onPrimary: Color(0xff3e1d00),
      primaryContainer: Color(0xffc4824c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc3dfff),
      onSecondary: Color(0xff002843),
      secondaryContainer: Color(0xff6695c2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdce1aa),
      onTertiary: Color(0xff242803),
      tertiaryContainer: Color(0xff8f9464),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffedd9cc),
      outline: Color(0xffc1aea3),
      outlineVariant: Color(0xff9e8d82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefdfd6),
      inversePrimary: Color(0xff6e3b09),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff200c00),
      primaryFixedDim: Color(0xffffb77f),
      onPrimaryFixedVariant: Color(0xff562b00),
      secondaryFixed: Color(0xffcfe5ff),
      onSecondaryFixed: Color(0xff001223),
      secondaryFixedDim: Color(0xff9ccbfb),
      onSecondaryFixedVariant: Color(0xff00395d),
      tertiaryFixed: Color(0xffe2e7b0),
      onTertiaryFixed: Color(0xff101300),
      tertiaryFixedDim: Color(0xffc6cb96),
      onTertiaryFixedVariant: Color(0xff343912),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff4d423c),
      surfaceContainerLowest: Color(0xff0c0603),
      surfaceContainerLow: Color(0xff241c16),
      surfaceContainer: Color(0xff2f2620),
      surfaceContainerHigh: Color(0xff3a312a),
      surfaceContainerHighest: Color(0xff463c35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffede1),
      surfaceTint: Color(0xffffb77f),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xfffdb278),
      onPrimaryContainer: Color(0xff170700),
      secondary: Color(0xffe7f1ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff99c7f7),
      onSecondaryContainer: Color(0xff000c1a),
      tertiary: Color(0xffeff4bc),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc2c792),
      onTertiaryContainer: Color(0xff0a0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffede1),
      outlineVariant: Color(0xffd2bfb3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefdfd6),
      inversePrimary: Color(0xff6e3b09),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb77f),
      onPrimaryFixedVariant: Color(0xff200c00),
      secondaryFixed: Color(0xffcfe5ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9ccbfb),
      onSecondaryFixedVariant: Color(0xff001223),
      tertiaryFixed: Color(0xffe2e7b0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6cb96),
      onTertiaryFixedVariant: Color(0xff101300),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff594e47),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff261e18),
      surfaceContainer: Color(0xff382f28),
      surfaceContainerHigh: Color(0xff433a33),
      surfaceContainerHighest: Color(0xff4f453e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// orange
  static const orange = ExtendedColor(
    seed: Color(0xff4f3017),
    value: Color(0xff4f3017),
    light: ColorFamily(
      color: Color(0xff895020),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcc4),
      onColorContainer: Color(0xff6d3a09),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff895020),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcc4),
      onColorContainer: Color(0xff6d3a09),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff895020),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcc4),
      onColorContainer: Color(0xff6d3a09),
    ),
    dark: ColorFamily(
      color: Color(0xffffb781),
      onColor: Color(0xff4e2600),
      colorContainer: Color(0xff6d3a09),
      onColorContainer: Color(0xffffdcc4),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb781),
      onColor: Color(0xff4e2600),
      colorContainer: Color(0xff6d3a09),
      onColorContainer: Color(0xffffdcc4),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb781),
      onColor: Color(0xff4e2600),
      colorContainer: Color(0xff6d3a09),
      onColorContainer: Color(0xffffdcc4),
    ),
  );

  /// blue
  static const blue = ExtendedColor(
    seed: Color(0xff1c3854),
    value: Color(0xff1c3854),
    light: ColorFamily(
      color: Color(0xff35618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff174974),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff35618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff174974),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff35618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff174974),
    ),
    dark: ColorFamily(
      color: Color(0xff9fcafc),
      onColor: Color(0xff003257),
      colorContainer: Color(0xff174974),
      onColorContainer: Color(0xffd1e4ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff9fcafc),
      onColor: Color(0xff003257),
      colorContainer: Color(0xff174974),
      onColorContainer: Color(0xffd1e4ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff9fcafc),
      onColor: Color(0xff003257),
      colorContainer: Color(0xff174974),
      onColorContainer: Color(0xffd1e4ff),
    ),
  );

  /// green
  static const green = ExtendedColor(
    seed: Color(0xff133a26),
    value: Color(0xff133a26),
    light: ColorFamily(
      color: Color(0xff286a48),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffadf2c7),
      onColorContainer: Color(0xff065232),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff286a48),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffadf2c7),
      onColorContainer: Color(0xff065232),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff286a48),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffadf2c7),
      onColorContainer: Color(0xff065232),
    ),
    dark: ColorFamily(
      color: Color(0xff92d5ac),
      onColor: Color(0xff003921),
      colorContainer: Color(0xff065232),
      onColorContainer: Color(0xffadf2c7),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff92d5ac),
      onColor: Color(0xff003921),
      colorContainer: Color(0xff065232),
      onColorContainer: Color(0xffadf2c7),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff92d5ac),
      onColor: Color(0xff003921),
      colorContainer: Color(0xff065232),
      onColorContainer: Color(0xffadf2c7),
    ),
  );

  /// red
  static const red = ExtendedColor(
    seed: Color(0xff502020),
    value: Color(0xff502020),
    light: ColorFamily(
      color: Color(0xff904a49),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad8),
      onColorContainer: Color(0xff733333),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff904a49),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad8),
      onColorContainer: Color(0xff733333),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff904a49),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad8),
      onColorContainer: Color(0xff733333),
    ),
    dark: ColorFamily(
      color: Color(0xffffb3b0),
      onColor: Color(0xff571d1e),
      colorContainer: Color(0xff733333),
      onColorContainer: Color(0xffffdad8),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb3b0),
      onColor: Color(0xff571d1e),
      colorContainer: Color(0xff733333),
      onColorContainer: Color(0xffffdad8),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb3b0),
      onColor: Color(0xff571d1e),
      colorContainer: Color(0xff733333),
      onColorContainer: Color(0xffffdad8),
    ),
  );

  /// gold
  static const gold = ExtendedColor(
    seed: Color(0xff4f462b),
    value: Color(0xff4f462b),
    light: ColorFamily(
      color: Color(0xff715c0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffee086),
      onColorContainer: Color(0xff564500),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff715c0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffee086),
      onColorContainer: Color(0xff564500),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff715c0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffee086),
      onColorContainer: Color(0xff564500),
    ),
    dark: ColorFamily(
      color: Color(0xffe0c46d),
      onColor: Color(0xff3c2f00),
      colorContainer: Color(0xff564500),
      onColorContainer: Color(0xfffee086),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffe0c46d),
      onColor: Color(0xff3c2f00),
      colorContainer: Color(0xff564500),
      onColorContainer: Color(0xfffee086),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffe0c46d),
      onColor: Color(0xff3c2f00),
      colorContainer: Color(0xff564500),
      onColorContainer: Color(0xfffee086),
    ),
  );

  /// silver
  static const silver = ExtendedColor(
    seed: Color(0xff414244),
    value: Color(0xff414244),
    light: ColorFamily(
      color: Color(0xff2d628b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcde5ff),
      onColorContainer: Color(0xff094a72),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff2d628b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcde5ff),
      onColorContainer: Color(0xff094a72),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff2d628b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcde5ff),
      onColorContainer: Color(0xff094a72),
    ),
    dark: ColorFamily(
      color: Color(0xff99ccfa),
      onColor: Color(0xff003352),
      colorContainer: Color(0xff094a72),
      onColorContainer: Color(0xffcde5ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff99ccfa),
      onColor: Color(0xff003352),
      colorContainer: Color(0xff094a72),
      onColorContainer: Color(0xffcde5ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff99ccfa),
      onColor: Color(0xff003352),
      colorContainer: Color(0xff094a72),
      onColorContainer: Color(0xffcde5ff),
    ),
  );

  /// bronze
  static const bronze = ExtendedColor(
    seed: Color(0xff4e443c),
    value: Color(0xff4e443c),
    light: ColorFamily(
      color: Color(0xff86521a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcbf),
      onColorContainer: Color(0xff6a3b02),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff86521a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcbf),
      onColorContainer: Color(0xff6a3b02),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff86521a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdcbf),
      onColorContainer: Color(0xff6a3b02),
    ),
    dark: ColorFamily(
      color: Color(0xfffeb876),
      onColor: Color(0xff4b2800),
      colorContainer: Color(0xff6a3b02),
      onColorContainer: Color(0xffffdcbf),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfffeb876),
      onColor: Color(0xff4b2800),
      colorContainer: Color(0xff6a3b02),
      onColorContainer: Color(0xffffdcbf),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfffeb876),
      onColor: Color(0xff4b2800),
      colorContainer: Color(0xff6a3b02),
      onColorContainer: Color(0xffffdcbf),
    ),
  );

  /// black
  static const black = ExtendedColor(
    seed: Color(0xff252627),
    value: Color(0xff252627),
    light: ColorFamily(
      color: Color(0xff1b6585),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3e8ff),
      onColorContainer: Color(0xff004c68),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff1b6585),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3e8ff),
      onColorContainer: Color(0xff004c68),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff1b6585),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc3e8ff),
      onColorContainer: Color(0xff004c68),
    ),
    dark: ColorFamily(
      color: Color(0xff8fcff3),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff004c68),
      onColorContainer: Color(0xffc3e8ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff8fcff3),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff004c68),
      onColorContainer: Color(0xffc3e8ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff8fcff3),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff004c68),
      onColorContainer: Color(0xffc3e8ff),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    orange,
    blue,
    green,
    red,
    gold,
    silver,
    bronze,
    black,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
