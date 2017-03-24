//: Playground - noun: a place where people can play


import PlaygroundSupport
import TastyTomato


// // Setup playground execution and liveView // //
PlaygroundPage.current.needsIndefiniteExecution = true
let liveView: UIView = UIView(
    frame: CGRect(x: 0, y: 0, width: 300, height: 800)
)
PlaygroundPage.current.liveView = liveView
liveView.backgroundColor = .white
liveView.tintColor = .white
// // // // // // // // // // // // // // // // //



let filledButton: FilledButton = FilledButton_()
filledButton.setTitle("FilledButton")
filledButton.setFillColor(.black)


















































liveView.addSubview(filledButton)
filledButton.top = 10
filledButton.left = 10

