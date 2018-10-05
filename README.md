# JPShrinkingButton


[![GitHub releases](https://img.shields.io/github/release/Julp04/JPShrinkingButton.svg)](https://github.com/Julp04/JPShrinkingButton/releases)

![Alt text](https://github.com/Julp04/JPShrinkingButton/blob/master/JPShrinkingButton.gif)

## Example

To run the example project, clone the repo. No need to run any carthage commands. Framework is included in project 😀

## Installation

To integrate JPShrinkingButton into your Xcode project using Carthage, specify it in your Cartfile:

```
github julp04/JPShrinkingButton
```

1. Run `carthage update`
1. A `Cartfile.resolved` file and a `Carthage` directory will appear in the same directory where your `.xcodeproj` or `.xcworkspace` is
1. Drag the built `.framework` binaries from `Carthage/Build/<platform>` into your application’s Xcode project.
1. If you are using Carthage for an application, follow the remaining steps, otherwise stop here.
1. On your application targets’ _Build Phases_ settings tab, click the _+_ icon and choose _New Run Script Phase_. Create a Run Script in which you specify your shell (ex: `/bin/sh`), add the following contents to the script area below the shell:

    ```sh
    /usr/local/bin/carthage copy-frameworks
    ```

- Add the paths to the frameworks you want to use under “Input Files". For example:

    ```
    $(SRCROOT)/Carthage/Build/iOS/JPShrinkingButton.framework
    ```

- Add the paths to the copied frameworks to the “Output Files”. For example:

    ```
    $(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/JPShrinkingButton.framework
    ```

# Usage

## Initalizing Button

### Setup Button

Works just like any normal UIButton where you can set titles, images, etc.

```swift
button = JPShrinkingButton(frame: buttonFrame)

button?.setTitle("Send Message", for: .normal)
button?.setImage(#imageLiteral(resourceName: "message.png"), for: .normal)
button?.tintColor = .white
button?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
button?.addTarget(self, action: #selector(showAlert), for: .touchUpInside)

view.addSubview(button!)
```

### Animations

There are two methods for animating the button: Expand and shrink


```swift
func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      if velocity.y >= 0.6 {
          button?.shrink()
          return
      }

      if velocity.y <= -0.6 {
          button?.expand()
          return
      }
}
```




## Author

julp04, julpanucci@gmail.com

## License

JPShrinkingButton is available under the MIT license. See the LICENSE file for more info.

