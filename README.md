# Flexi

Flexi is a Flutter package that provides a flexible widget for zooming, panning, and rotating child widgets.

<img src="gif/ezgif.com-video-to-gif.gif" alt="Alt Text" height="400"/>

## Features

- Zoom in and out of a widget.
- Pan the widget by dragging it.
- Rotate the widget using gestures.
- Double-tap to reset the widget to its original state.
- Configurable minimum and maximum scale limits.
- Configurable maximum translation limits along the X and Y axes.
- Enable/disable rotation, scaling, and translation individually.
- Support for custom callbacks on scale start, update, and end events.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flexi: ^1.0.0
  ```
## Usage

**Import the package in your Dart file:**

```import 'package:flexi/flexi.dart';```

**Wrap your widget with the Flexi widget:**
``` yaml
Flexi(
  child: YourWidget(),
  minScale: 0.8, // Set the minimum scale limit (optional)
  maxScale: 2.5, // Set the maximum scale limit (optional)
  onScaleUpdate: (offset, scale, rotation) {
    // Handle scale update event
  },
  onScaleEnd: (details) {
    // Handle scale end event
  },
)
```
## Parameters

1. **child**: The child widget that you want to apply zoom, pan, and rotate features to. (required)
2. **minScale**: The minimum scale factor for scaling the widget. Defaults to 0.8. (optional)
3. **maxScale**: The maximum scale factor for scaling the widget. Defaults to 2.5. (optional)
4. **onScaleUpdate**: A callback function that is triggered during the scale update event. It provides the current offset, scale factor, and rotation angle as parameters. (optional)
5. **onScaleEnd**: A callback function that is triggered when the scale event ends. It provides the scale end details as a parameter. (optional)
6. **canRotate**: Flag to enable/disable rotation. Defaults to true. (optional)
7. **canScale**: Flag to enable/disable scaling. Defaults to true. (optional)
8. **canTranslate**: Flag to enable/disable translation. Defaults to true. (optional)
9. **returnToOrigin**: Flag to enable/disable returning to the original state on double-tap. Defaults to true. (optional)
10. **enabled**: Flag to enable/disable the Flexi widget. Defaults to true. (optional)
11. **maxTranslationX**: The maximum translation value along the X-axis. Defaults to 100. (optional)
12. **maxTranslationY**: The maximum translation value along the Y-axis. Defaults to 100. (optional)

## Example

Check out the example directory for a working example of using the Flexi widget.

## Running Tests

To run the tests for the Flexi package, use the following command:
```flutter test flexi_test.dart```

## Contributing

Contributions are welcome! Please submit any issues or pull requests via the GitHub repository.

## License

This project is licensed under the MIT License.



Feel free to customize the content further based on your package's specific details and testing instructions.