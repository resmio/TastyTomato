//
//  TagView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


@objc public protocol TagViewDelegate: class {
    func tagViewDeleteButtonTapped(_ tagView: TagView)
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
        super.init(frame: CGRect.zero)
        self._label.text = name
        
        self._setupLayer()
        self._setupSubviews()
        self._adjustWidth()
        self._centerViewsVertically()
        self._resetColor()
    }
    
    // Private Constant Stored Properties
    fileprivate let _backgroundAlpha: CGFloat = 0.1
    fileprivate let _horizontalSpacing: CGFloat = 10
    fileprivate let _height: CGFloat = 35.5
    fileprivate let _leftBannerWidth: CGFloat = 8
    fileprivate let _label: UILabel = UILabel()
    fileprivate let _labelHeight: CGFloat = 20
    fileprivate let _fontSize: CGFloat = 16
    fileprivate let _deleteIconSideLength: CGFloat = 15
    
    // Private Variable Stored Properties
    fileprivate weak var _delegate: TagViewDelegate?
    
    fileprivate var _leftBannerView: UIView!
    fileprivate var _deleteButton: UIButton!
    
    fileprivate var _color: UIColor = .yellowF8C150
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
        self._setColor(.redE62C4F)
    }
}


// MARK: Set / Reset Color
extension TagView {
    func setColor_(_ color: UIColor, temporary: Bool) {
        self._setColor(color, temporary: temporary)
    }
    
    func resetColor_() {
        self._resetColor()
    }
}


// MARK: // Private
// MARK: Setup Layer
private extension TagView {
    func _setupLayer() {
        self.clipsToBounds = true
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        
        self.height = self._height
    }
}


// MARK: Setup Subviews
private extension TagView {
    func _setupSubviews() {
        self._setupLabel()
        self._setupLeftBannerView()
        self._setupDeleteButton()
    }
    
    func _setupLabel() {
        self._label.font = UIFont.systemFont(ofSize: self._fontSize)
        self._label.textColor = .gray555555
        self._label.sizeToFit()
        self._label.height = self._labelHeight
        
        self.addSubview(self._label)
    }
    
    func _setupLeftBannerView() {
        let leftBannerView: UIView = UIView(size:
            CGSize(width: self._leftBannerWidth, height: self.height)
        )
        
        leftBannerView.backgroundColor = self._color
        
        self._leftBannerView = leftBannerView
        self.addSubview(leftBannerView)
    }
    
    func _setupDeleteButton() {
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
            for: UIControlState()
        )
        deleteButton.tintColor = .gray555555
        
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped_),
            for: .touchUpInside
        )
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTouchDown_),
            for: .touchDown
        )
        deleteButton.addTarget(
            self,
            action: #selector(resetColor_),
            for: .touchDragExit
        )
        
        self._deleteButton = deleteButton
        self.addSubview(deleteButton)
    }
}


// MARK: Center Views Vertically
private extension TagView {
    func _centerViewsVertically() {
        self._leftBannerView.centerVInSuperview()
        self._label.centerVInSuperview()
        self._deleteButton.centerVInSuperview()
    }
}


// MARK: Adjust Width
private extension TagView {
    func _adjustWidth() {
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
    func _setColor(_ color: UIColor, temporary: Bool = true) {
        self.backgroundColor = color.withAlpha(self._backgroundAlpha)
        self.layer.borderColor = color.cgColor
        self._leftBannerView.backgroundColor = color
        if !temporary {
            self._color = color
        }
    }
    
    func _resetColor() {
        self.setColor_(self._color, temporary: false)
    }
}
