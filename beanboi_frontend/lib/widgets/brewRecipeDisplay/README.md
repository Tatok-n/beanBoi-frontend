# Brew Recipe Chart Feature

This feature adds interactive charts to the recipe creation workflow in the BeanBoi app.

## Overview

The chart feature is implemented as a new step in the brew recipe creation process. It provides three different chart types to visualize brewing recipe data:

1. **Brewing Profile Chart** - Line chart showing temperature/extraction over time
2. **Parameters Chart** - Pie chart showing the relationship between ratio, temperature, and duration
3. **Stages Chart** - Bar chart showing the intensity of each brewing stage

## Files Added/Modified

### New Files:
- `lib/widgets/brewRecipeDisplay/brewRecipeChart.dart` - Main chart widget
- `lib/widgets/brewRecipeDisplay/chartTestApp.dart` - Standalone test app for chart development
- `test/brew_recipe_chart_test.dart` - Widget tests for the chart component

### Modified Files:
- `pubspec.yaml` - Added fl_chart dependency
- `lib/widgets/brewRecipeDisplay/brewRecipeDisplay.dart` - Integrated chart as third step

## Chart Features

### 1. Brewing Profile Chart
- Displays temperature/extraction curve over time
- Shows brewing stages as data points
- Responsive to recipe parameters (temperature, duration, number of stages)

### 2. Parameters Chart
- Pie chart visualization of recipe parameters
- Shows ratio, temperature, and duration proportionally
- Interactive with tooltips

### 3. Stages Chart
- Bar chart showing brewing intensity per stage
- Configurable number of stages (1-10)
- Shows decreasing intensity over time (simulated brewing behavior)

## Usage

The chart is integrated into the recipe creation workflow as Step 3:

1. **Step 1**: General recipe information (method, ratio, temperature, duration)
2. **Step 2**: Number of brewing stages
3. **Step 3**: Recipe visualization with interactive charts and summary

## Dependencies

- `fl_chart: ^0.68.0` - Flutter charting library

## Testing

Run the chart-specific tests:
```bash
flutter test test/brew_recipe_chart_test.dart
```

Run the standalone chart test app:
```bash
flutter run lib/widgets/brewRecipeDisplay/chartTestApp.dart
```

## Chart Customization

The charts are fully customizable and responsive to recipe parameters. They automatically update when users modify:
- Brewing method (Espresso vs V60)
- Ratio (0.5 - 20.0)
- Temperature (60°C - 100°C)
- Duration (5s - 240s)
- Number of stages (1 - 10)

## Future Enhancements

Potential improvements for the chart feature:
- Real-time brewing data integration
- Historical recipe comparison
- Export chart as image
- More chart types (scatter plot, area chart)
- Custom color themes
- Animation transitions between chart types