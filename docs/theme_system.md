# Theme System Documentation

This document outlines the comprehensive theming system used in the SparX Wallet Flutter application, including the design system, component library, and best practices for consistent UI development.

## Overview

The SparX Wallet implements a sophisticated theming system with two versions:

- **Legacy v1 theme system** (deprecated, being phased out)
- **Current v2 theme system** (active, recommended for all new development)

The theme system is centralized in the `packages/ui_components_lib/` directory as a separate package, providing a unified design system and component library.

## Theme Architecture

### Directory Structure

```
packages/ui_components_lib/lib/
├── v2/                           # Current theme system (v2)
│   ├── colors_v2.dart           # Color palette definitions
│   ├── dimens_v2.dart           # Size and spacing design tokens
│   ├── opac_v2.dart             # Opacity constants
│   ├── predefined_theme_v2.dart # Theme configurations
│   ├── text_styles_v2.dart      # Typography system
│   ├── theme_style_v2.dart      # Theme extension
│   ├── widgets/                  # V2 UI components
│   └── ui_components_lib_v2.dart # Export file
├── legacy files...               # V1 theme system (deprecated)
└── utils/                        # Shared utilities
```

### Theme Extension System

The project uses Flutter's `ThemeExtension` pattern for custom theming:

```dart
class ThemeStyleV2 extends ThemeExtension<ThemeStyleV2> {
  ThemeStyleV2({
    required this.colors,
    required this.textStyles,
  });

  final ColorsPaletteV2 colors;
  final TextStylesV2 textStyles;
}
```

## Color System

### Semantic Color Organization

The color system is organized into semantic groups for consistent usage through the `ColorsPaletteV2` class:

**Core Brand Colors:**

- `primaryA`, `primaryB` - Primary color variants
- `accent` - Accent color for highlights
- `negative`, `warning`, `positive` - State-specific colors

**Background Colors:**

- `background0` through `background3` - Hierarchical background levels
- `backgroundInput`, `backgroundAccent` - Specialized backgrounds
- Alpha variants for transparency effects

**Content Colors:**

- `content0` through `content4` - Text hierarchy from primary to quinary
- Used for different text importance levels

**Border Colors:**

- `border0` through `border2` - Standard border hierarchy
- `borderFocus`, `borderDisabled` - State-specific borders

### Raw Color Resources

Colors are systematically defined in `ColorsResV2` using a structured naming convention:

**Color Categories:**

- **Primary colors** (`p10`-`p100`) - Brand purple tones
- **Neutral colors** (`n10`-`n100`) - Grayscale from dark to white
- **Error colors** (`e10`-`e100`) - Red/pink error states
- **Success colors** (`s10`-`s100`) - Green success states  
- **Warning colors** (`w10`-`w100`) - Yellow/orange warning states

The numbering system (10-100) represents intensity levels, with higher numbers typically being lighter/more saturated.

## Typography System

### Text Style Hierarchy

The typography system provides semantic text styles through `TextStylesV2` with consistent hierarchy:

**Display Styles** (largest, for hero content):

- `displayLarge` (52px), `displayMedium` (44px), `displaySmall` (36px)
- Weight: 700 (bold)

**Heading Styles** (for section titles):

- `headingXXLarge` (36px) through `headingXSmall` (14px)
- Weight: 700 (bold)
- Six size variants for different heading levels

**Label Styles** (for UI labels and buttons):

- `labelLarge` (18px) through `labelXSmall` (12px)
- Weight: 500 (medium)
- Four size variants for interface elements

**Paragraph Styles** (for body text):

- `paragraphLarge` (18px) through `paragraphXSmall` (12px)
- Weight: 400 (regular)
- Five size variants including `paragraphXMedium` (17px)

### Font Configuration

All text styles use the **Inter** font family with:

- Responsive sizing using `.spp` extension (screen-proportional pixels)
- Calculated line heights (height = lineHeight / fontSize)
- Negative letter spacing for tighter text
- Theme-aware color application

## Design Tokens

### Size and Spacing Tokens

`DimensSizeV2` provides standardized spacing values:

- **Available sizes**: `d4`, `d8`, `d12`, `d16`, `d24`, `d32`, `d40`, `d48`, `d56`, `d64`
- **Usage**: Padding, margins, and component sizing
- **Scale**: 4px increments for consistent spacing rhythm

### Border Radius Tokens

`DimensRadiusV2` defines corner radius standards:

- **Available radii**: `radius8`, `radius12`, `radius16`, `radius24`, `radius32`
- **Usage**: Card corners, button borders, input fields
- **Hierarchy**: From subtle to pronounced rounding

### Stroke/Border Tokens

`DimensStrokeV2` provides border width standards:

- **small** (1px) - Default borders, dividers
- **medium** (2px) - Emphasized borders, focus states

### Opacity Constants

`OpacV2` defines transparency levels:

- **Available opacities**: `opac10` (0.1), `opac16` (0.16), `opac50` (0.5), `opac80` (0.8), `opac100` (1.0)
- **Usage**: Overlays, disabled states, alpha backgrounds

## Theme Configuration

### App-Level Setup

The main app configures themes in `/lib/app/view/app.dart` using:

- `getPredefinedLightTheme()` for light theme
- `getPredefinedDarkTheme()` for dark theme
- Theme mode set to system preference

### Dark/Light Mode Implementation

**Note**: Currently, both light and dark themes use identical color definitions (dark color scheme). The app is designed as a dark-themed application without true light mode support. Both theme functions return the same dark color palette.

## Using Themes in Widgets

### Accessing Theme Data

```dart
@override
Widget build(BuildContext context) {
  final theme = context.themeStyleV2;      // Get theme extension
  final colors = theme.colors;             // Access color palette
  final textStyles = theme.textStyles;     // Access typography

  return Container(
    color: colors.background2,
    padding: EdgeInsets.all(DimensSizeV2.d16),
    child: Text(
      'Hello World',
      style: textStyles.headingMedium.copyWith(
        color: colors.content0,
      ),
    ),
  );
}
```

### Using Pre-built Components

#### Text Components

Use `PrimaryText` for semantic text with automatic theming:

- Available types: `displayLarge`, `headingLarge`, `labelMedium`, `paragraphSmall`, etc.
- Automatically applies theme colors and typography
- Supports text alignment and styling properties

#### Button Components

Available themed button variants:

- `PrimaryButton` - Main call-to-action buttons
- `AccentButton` - Secondary actions  
- `GhostButton` - Tertiary actions
- `DestructiveButton` - Delete/destructive actions
- All support shape variants, icons, and automatic theme styling

#### Cards and Containers

Pre-built container components:

- `PrimaryCard` - Standard card component with theme styling
- `ShapedContainerColumn/Row` - Layout containers with automatic theming
- Support for spacing, padding, and color customization

### Working with Alpha Colors

Apply transparency using opacity utilities:

- Use `colors.content0.withAlpha(OpacV2.opac50.toByteInt())` for custom transparency
- Use pre-defined alpha colors like `backgroundAlpha`, `backgroundButtonAlpha`
- Combine with design tokens for consistent transparency levels

## Component Library

### Available Component Categories

**Buttons:**
Primary, Accent, Ghost, Float, Destructive, Transparent variants with automatic theme styling

**Text Components:**
PrimaryText with all typography hierarchy levels and semantic styling

**Cards and Containers:**
PrimaryCard, ShapedContainerColumn/Row, and specialized layout containers

**Input Components:**
Text fields, dropdowns, checkboxes, switches with consistent theme integration

**Overlays and Navigation:**
Bottom sheets, toasts, snackbars, modal dialogs with theme styling

