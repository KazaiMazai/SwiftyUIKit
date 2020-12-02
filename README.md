# SwiftyUIKit

SwiftyUIKit is a featherweight lib for building layout in a clean and declarative way.

It allows to build autolayout-powered UIView layout almost the same way as it's done in SwiftUI 
while using the exact same UIKit API for views configuration.


### Make the UIKit great again!

```swift
final class ExampleView: UIView {
    private let theme: AppUITheme = .defaultTheme
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let imageView = UIImageView(frame: .zero)

    lazy var body = {
        HStackView(spacing: theme.paddings.normal) {
            VStackView {
                imageView.modify {
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
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
        .padding(bottomConstant: theme.paddings.large)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        add(body: body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```
