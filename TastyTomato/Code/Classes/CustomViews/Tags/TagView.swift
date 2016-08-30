//
//  TagView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


@objc public protocol TagViewDelegate: class {
    func tagViewDeleteButtonTapped(tagView: TagView)
}


// MARK: // Public
// MARK: Interface
public extension TagView {
    public var delegate: TagViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
}


// MARK: Class Declaration
public class TagView: UIView {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        fatalError("TagView does not support NSCoding")
    }
    
    // Init
    public init(name: String) {
        super.init(frame: CGRectZero)
        self._label.text = name
        
        self._setupLayer()
        self._setupSubviews()
        self._adjustWidth()
        self._centerViews()
        self._resetColor()
    }
    
    // Private Constant Stored Properties
    private let _backgroundAlpha: CGFloat = 0.1
    private let _horizontalSpacing: CGFloat = 10
    private let _height: CGFloat = 35.5
    private let _leftBannerWidth: CGFloat = 8
    private let _label: UILabel = UILabel()
    private let _labelHeight: CGFloat = 20
    private let _fontSize: CGFloat = 16
    private let _deleteIconSideLength: CGFloat = 15
    
    // Private Variable Stored Properties
    private weak var _delegate: TagViewDelegate?
    
    private var _leftBannerView: UIView!
    private var _deleteButton: UIButton!
    
    private var _color: UIColor = UIColor.YellowF8C150()
}


// MARK: Override
public extension TagView {
    public override func layoutSubviews() {
        self._label.sizeToFit()
        self._label.height = self._labelHeight
        self._label.left = self._leftBannerView.right + self._horizontalSpacing
        self._deleteButton.left = self._label.right
        self._adjustWidth()
    }
}


// MARK: // Internal
// MARK: Delete Button Target Selectors
extension TagView {
    func deleteButtonTapped_() {
        self.delegate?.tagViewDeleteButtonTapped(self)
        self._resetColor()
    }
    
    func deleteButtonTouchDown_() {
        self._setColor(UIColor.RedE62C4F())
    }
}


// MARK: Set / Reset Color
extension TagView {
    func setColor_(color: UIColor, temporary: Bool) {
        self._setColor(color, temporary: temporary)
    }
    
    func resetColor_() {
        self._resetColor()
    }
}


// MARK: // Private
// MARK: Setup Layer
private extension TagView {
    private func _setupLayer() {
        self.clipsToBounds = true
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        
        self.height = self._height
    }
}


// MARK: Setup Subviews
private extension TagView {
    private func _setupSubviews() {
        self._setupLabel()
        self._setupLeftBannerView()
        self._setupDeleteButton()
    }
    
    private func _setupLabel() {
        self._label.font = UIFont.systemFontOfSize(self._fontSize)
        self._label.textColor = UIColor.Gray555555()
        self._label.height = self._labelHeight
        
        self.addSubview(self._label)
    }
    
    private func _setupLeftBannerView() {
        let leftBannerView: UIView = UIView(size:
            CGSize(width: self._leftBannerWidth, height: self.height)
        )
        
        leftBannerView.backgroundColor = self._color
        
        self._leftBannerView = leftBannerView
        self.addSubview(leftBannerView)
    }
    
    private func _setupDeleteButton() {
        let deleteIcon: UIImage = MiscIcon.X.asTemplate()
        let scaledDeleteIcon: UIImage = deleteIcon.scaledToSize(
            CGSize(width: self._deleteIconSideLength, height: self._deleteIconSideLength)
        )
        
        let deleteButtonSideLength: CGFloat = self.height
        let deleteButton: UIButton = UIButton(size:
            CGSize(width: deleteButtonSideLength, height: deleteButtonSideLength)
        )
        
        deleteButton.setImage(
            scaledDeleteIcon,
            forState: .Normal
        )
        deleteButton.tintColor = UIColor.Gray555555()
        
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped_),
            forControlEvents: .TouchUpInside
        )
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTouchDown_),
            forControlEvents: .TouchDown
        )
        deleteButton.addTarget(
            self,
            action: #selector(resetColor_),
            forControlEvents: .TouchDragExit
        )
        
        self._deleteButton = deleteButton
        self.addSubview(deleteButton)
    }
}


// MARK: Center Views Vertically
private extension TagView {
    private func _centerViews() {
        self._leftBannerView.centerVInSuperview()
        self._label.centerVInSuperview()
        self._deleteButton.centerVInSuperview()
    }
}


// MARK: Adjust Width
private extension TagView {
    private func _adjustWidth() {
        self.width = (
            self._leftBannerView.width +
            self._horizontalSpacing +
            self._label.width +
            self._deleteButton.width
        )
    }
}


// MARK: Set Color
private extension TagView {
    private func _setColor(color: UIColor, temporary: Bool = true) {
        self.backgroundColor = color.withAlpha(self._backgroundAlpha)
        self.layer.borderColor = color.CGColor
        self._leftBannerView.backgroundColor = color
        if !temporary {
            self._color = color
        }
    }
    
    private func _resetColor() {
        self.setColor_(self._color, temporary: false)
    }
}
