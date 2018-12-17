# 3D Touch

> iPhone 6s and iPhone 6s Plus bring a powerful new dimension to the Multi-Touch interface with 3D Touch. This new technology senses how deeply users press the display, letting them do more than ever with your apps and games.
>
> — developer.apple.com

3D Touch 是 iPhone 6s 及以后机型带来的新功能，是一种立体触控技术，可以感应不同的感压力度。在 app 开发中，主要分为三大模块：`Quick Actions`、`Peek and Pop`、`Pressure Sensitivity`

## 1. Quick Actions

在 Home 界面按压 app 图片，可以显示最多 4 个标签。点击不同的标签可以进入 app 并且处理相应的事件。下面来看下实现方法

创建 `Quick Actions` 有两种方式，1) 在 info.plist 文件中静态声明；2) 在程序初始化时利用代码动态添加

* 静态声明

![](https://ww2.sinaimg.cn/large/006tNc79gy1fcj1l8ewvzj30w805iabd.jpg)

```
	<key>UIApplicationShortcutItems</key>
	<array>
		<dict>
			<key>UIApplicationShortcutItemType</key>
			<string>share</string>
			<key>UIApplicationShortcutItemTitle</key>
			<string>分享</string>
			<key>UIApplicationShortcutItemIconType</key>
			<string>UIApplicationShortcutIconTypeShare</string>
		</dict>
	</array>
```

如上，其中`UIApplicationShortcutItemType`、`UIApplicationShortcutItemTitle `是必填项。`UIApplicationShortcutItemIconType`、`UIApplicationShortcutItemIconFile`、`UIApplicationShortcutItemSubtitle`为选填项。

* 动态添加

通过代码，指定`application.shortcutItems`快捷方式数组，可在如下方法中添加 (具体位置可根据自己情况而定)。

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let shareItem = UIApplicationShortcutItem(type: "share", localizedTitle: "分享", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .share), userInfo: nil)
    // ... 更多 item 设置
    application.shortcutItems = [shareItem]
    return true
}
```

运行程序后，按压 app 图标，将可以看到一个「分享」的标签。

* 响应回调

`UIApplication`提供了一个方法接听 `shortcutItem`的点击

```swift
func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
	// 可通过之前设置的 type 唯一标示区分点击的按钮，作出不同的响应
    switch shortcutItem.type {
    case "share":
        print("clicked share")
    default:
        break
    }
}
```

在 iOS10 中，如果该 app 还添加了 todayExtension。在按压 app 图标后，在 quick actions 上方还会显示该 app 的 widget。如果自带的「天气」app。

![](https://ww2.sinaimg.cn/large/006tNc79gy1fcj28zawguj30ka0mm7pp.jpg)

## 2. Peek and Pop

![](https://ww1.sinaimg.cn/large/006tNc79gy1fcj2mbh4iyj317i0p0jxj.jpg)

Peek and Pop 大概分为 3 个步骤，1) 轻按，焦点高亮其余部分变模糊。2) 加大力度，出现目标 ViewController 预览。3) 这时可以继续重压 push 至目标 ViewController (或者自定义动作)；或者手指上滑，将出现右图的`PreviewAction`

由于 3D Touch 需要 iPhone 6s 以上机型支持，所以需要判断 3D Touch 的可用性

```swift
traitCollection.forceTouchCapability == .available ? _ = registerForPreviewing(with: self, sourceView: cell) : ()
```

这里使用了一个三目，如果是可用的，则执行`registerForPreviewing`注册，设置 cell 为 sourceView

接下来遵循`UIViewControllerPreviewingDelegate`协议，实现其方法

```swift
extension ViewController: UIViewControllerPreviewingDelegate {
    
    // 重压后触发
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    // 返回触发 Peek 事件的原始图
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let detailViewController = DetailViewController()
        return detailViewController
    }
    
}
```

上滑后出现的 `PreviewAction`需要在目标 ViewController 中实现。同样需要注册 `registerForPreviewing`和遵循`UIViewControllerPreviewingDelegate`。并且额外重写一个计算型属性

```swift
override var previewActionItems: [UIPreviewActionItem] {
    let item = UIPreviewAction(title: "Greet", style: .default) { (action, viewController) in
        print("Hello")
    }
    return [item]
}
```

