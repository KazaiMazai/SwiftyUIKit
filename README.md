# SwiftyUIKit

SwiftyUIKit is a featherweight lib that allows to build an autolayout-powered UIView layout in a clean SwiftUI-style DSL
while using pure UIKit API for views configuration and additional layout tweaking.

```swift
final class ExampleView: UIView {
    private let theme: AppUITheme = .defaultTheme
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let imageView = UIImageView(frame: .zero)

    private lazy var body = {
        HStackView(spacing: theme.paddings.normal) {
            VStackView {
                imageView.modify {
                    $0.contentMode = .scaleAspectFill
                    $0.widthAnchor
                        .constraint(equalTo: $0.heightAnchor, multiplier: 1.0)
                        .isActive = true
                    $0.heightAnchor
                        .constraint(equalToConstant: theme.sizes.avatar)
                        .isActive = true
                }

                SpacerView()
            }

            VStackView(spacing: theme.paddings.small) {
                titleLabel.modify {
                    $0.numberOfLines = 0
                }
                subtitleLabel.modify {
                    $0.numberOfLines = 0
                }
            }
        }
        .modify {
            $0.heightAnchor
                .constraint(greaterThanOrEqualToConstant: theme.sizes.avatar)
                .isActive = true
        }
        .padding(bottom: theme.paddings.large)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        add(body: body)
    }
}
```

## Reasons

- I love to be as close to UIKit API as possible and play with NSLayoutConstraints directly
- Sometimes NSLayoutConstraints are too verbose especially after SwiftUI experience
- I'm not a fan of using monster-sized 3rd party libs for building UI layout

So here is a SwiftyUIKit consisting of just 4 views, 1 decorator and 1 closure that does all the work!

### Why not just UIStackView?

What if I want a lightweight layout with views just stacked statically without rearrangement and any other overhead brought by UIStackView?

## What's inside

### Views

The whole lib consist of just a few guys:
- HStackView
- VStackView
- ZStackView
- SpacerView


As we have all experienced in SwiftUI it's usually enough for 90% of the layouts. 

### Paddings Decorator

Decorates view with paddings all over: 
```swift

UILabel().padding(16)

```

or with specified sides:

```swift 
UILabel().padding(left: 8,
                  right: 8)
```

### Add body:


```swift
func add(body: UIView) 
```

It just adds body view as subview with its edges anchored to the parent view's edges

### Modifier sugar
It's just a closure to make the layout description look more expressive, compact and neat.

#### UIViews:

```
UIView().modify {
    $0.backgroundColor = .red
}
```

#### NSLayoutConstraints ans NSLayoutAnchors:

```swift
UIView()
    .leftAnchor
    .constraint(equalTo: leftAnchor)
    .modify {
        $0.priority = .defaultHigh
        $0.isActive = true
    }
```
#### Arrays of all the modifiable guys mentioned above:

```swift
UIImageView().modify {
        [$0.heightAnchor, $0.widthAnchor].modify { anchor in
                anchor.constraint(equalToConstant: 32)
                      .isActive = true
    }
}

```

or

```swift
[tickerLabel, subtitleLabel].modify {
    $0.font = veryNiceFont
}

```
                   

## Installation

### Swift Package Manager.

SwiftyUIKit is available through Swift Package Manager. 
To install it, in Xcode 11.0 or later select File > Swift Packages > Add Package Dependency... and add SwiftyUIKit repository URL:

```
https://github.com/KazaiMazai/SwiftyUIKit
```
 




