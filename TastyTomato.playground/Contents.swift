//: Playground - noun: a place where people can play


import PlaygroundSupport
import TastyTomato


// // Setup playground execution and liveView // //
PlaygroundPage.current.needsIndefiniteExecution = true
let liveView: UIView = UIView(
    frame: CGRect(x: 0, y: 0, width: 300, height: 2000)
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


// CustomViews















































var nextViewTop: CGFloat = 50
for view in viewsToDisplay {
    liveView.addSubview(view)
    view.left = 10
    view.top = nextViewTop
    nextViewTop = view.bottom + 50
}
