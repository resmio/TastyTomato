//: Playground - noun: a place where people can play


import PlaygroundSupport
import TastyTomato


// // Setup-boilerplate // //
PlaygroundPage.current.needsIndefiniteExecution = true
let liveView: UIView = UIView(
    frame: CGRect(x: 0, y: 0, width: 500, height: 1000)
)
PlaygroundPage.current.liveView = liveView
liveView.backgroundColor = .white
liveView.tintColor = .white
// // // // // // // // // // // // // // // // //

var viewsToDisplay: [UIView] = []


// ButtonClasses
let baseButton: BaseButton = BaseButton_()
baseButton.autoAdjustWidthOnTitleSet = true
baseButton.setTitle("BaseButton")
baseButton.tintColor = .black
viewsToDisplay.append(baseButton)


let filledButton: FilledButton = FilledButton_()
filledButton.setTitle("FilledButton")
filledButton.setFillColor(.black)
filledButton.setHighlightedAlpha(0.01)
viewsToDisplay.append(filledButton)


let shortcutBarButton: ShortcutBarButton = ShortcutBarButton_()
shortcutBarButton.setTitle("ShortcutBarButton")
viewsToDisplay.append(shortcutBarButton)


let textButton: TextButton = TextButton_()
textButton.setTitle("TextButton")
textButton.underlined = true
viewsToDisplay.append(textButton)


// LabelClasses
let baseLabel: BaseLabel = BaseLabel()
baseLabel.text = "Test Text For Resizing"
baseLabel.sizeToFit()
//baseLabel.text = nil
baseLabel.placeholder = "Placeholder"
viewsToDisplay.append(baseLabel)


// CustomViews
let shortcutBar: ShortcutBar = ShortcutBar()
shortcutBar.width = 300
var barButtons: [UIBarButtonItem] = []
for i in 0...20 {
    let shortcutBarButton2: ShortcutBarButton = ShortcutBarButton_()
    shortcutBarButton2.setTitle("\(i)")
    barButtons.append(shortcutBarButton2.asBarButtonItem())
}
shortcutBar.setItems(barButtons, animated: false)
viewsToDisplay.append(shortcutBar)


// Doesn't work in playground yet because 
// the MiscIcon-x image cannot be found
//let tagView: TagView = TagView(name: "TagView")
//let tagsView: TagsView = TagsView()



// Layers
let borderLayerViewSize: CGSize = CGSize(width: 200, height: 200)
let borderLayerView: UIView = UIView(size: borderLayerViewSize)
borderLayerView.backgroundColor = UIColor.red.withAlpha(0.2)
let borderLayer: BorderLayer = BorderLayer()
borderLayer.frame = borderLayerViewSize.asCGRect()
borderLayer.borderEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 5, right: 20)
borderLayer.lineWidth = 1
borderLayer.lineDashPattern = [6, 6]
borderLayerView.layer.addSublayer(borderLayer)
viewsToDisplay.append(borderLayerView)










































var nextViewTop: CGFloat = 50
for view in viewsToDisplay {
    liveView.addSubview(view)
    view.left = 10
    view.top = nextViewTop
    nextViewTop = view.bottom + 50
}
