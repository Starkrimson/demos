# YogaKitSample

[Yoga Tutorial: Using a Cross-Platform Layout Engine](https://www.raywenderlich.com/161413/yoga-tutorial-using-cross-platform-layout-engine?utm_source=raywenderlich.com+Weekly&utm_campaign=e7e557ef6a-raywenderlich_com_Weekly_Issue_125&utm_medium=email&utm_term=0_83b6edc87f-e7e557ef6a-415701885)

[翻译-yoga-教程-使用跨平台布局引擎](https://archimboldi.me/posts/翻译-yoga-教程-使用跨平台布局引擎.html)

```swift
let contentView = UIView()
contentView.backgroundColor = .lightGray
contentView.configureLayout { (layout) in
    layout.isEnabled = true
    layout.flexDirection = .row
    layout.width = 280
    layout.height = 80
    layout.marginTop = 40
    layout.marginLeft = 20
    layout.padding = 10
}
view.addSubview(contentView)
contentView.yoga.applyLayout(preservingOrigin: true)
```

