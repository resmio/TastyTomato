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
    
    public var name: String? {
        get {
            return self._name
        }
        set(newName) {
            self._name = newName
        }
    }
}


// MARK: Class Declaration
public class TagView: UIView {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("TagView does not support NSCoding")
    }
    
    // Init
    public init(name: String) {
        super.init(frame: CGRectZero)
        self._name = name
        
        self._setup()
        self._setupSubviews()
        self._adjustWidth()
        self._centerViews()
    }
    
    // Private Constant Stored Properties
    private let _color: UIColor = UIColor.YellowF8C150()
    private let _backgroundAlpha: CGFloat = 0.1
    private let _label: UILabel = UILabel()
    private let _verticalInset: CGFloat = 8
    private let _horizontalSpacing: CGFloat = 10
    private let _fontSize: CGFloat = 16
    
    // Private Variable Stored Properties
    private weak var _delegate: TagViewDelegate?
    
    private var _leftBannerView: UIView!
    private var _deleteButton: UIButton!
}


// MARK: Override
public extension TagView {
    public override func layoutSubviews() {
        self._label.sizeToFit()
        self._adjustWidth()
        self._label.left = self._leftBannerView.right + self._horizontalSpacing
        self._deleteButton.left = self._label.right
    }
}


// MARK: // Internal
// MARK: Delete Button Target Selector
extension TagView {
    func deleteButtonTapped_() {
        self.delegate?.tagViewDeleteButtonTapped(self)
    }
}


// MARK: // Private
// MARK: Computed Properties
private extension TagView {
    private var _name: String? {
        get {
            return self._label.text
        }
        set(newName) {
            self._label.text = newName
        }
    }
}


// MARK: Setup Layer
private extension TagView {
    private func _setup() {
        self.clipsToBounds = true
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = self._color.CGColor
        
        self.backgroundColor = self._color.withAlpha(self._backgroundAlpha)
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
        self._label.sizeToFit()
        
        self.height = self._label.height + (2 * self._verticalInset)
        self.addSubview(self._label)
    }
    
    private func _setupLeftBannerView() {
        let leftBannerView: UIView = UIView(size: CGSize(width: 8, height: self.height))
        leftBannerView.backgroundColor = self._color
        
        self._leftBannerView = leftBannerView
        self.addSubview(self._leftBannerView)
    }
    
    private func _setupDeleteButton() {
        let deleteIcon: UIImage = MiscIcon.X.asTemplate()
        let sideLength: CGFloat = self._label.height * 0.8
        let scaledDeleteIcon: UIImage = deleteIcon.scaledToSize(CGSize(width: sideLength, height: sideLength))
        
        let deleteButtonSideLength: CGFloat = self.height
        let deleteButton: UIButton = UIButton(size: CGSize(width: deleteButtonSideLength, height: deleteButtonSideLength))
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
        
        self._deleteButton = deleteButton
        self.addSubview(self._deleteButton)
    }
}


// MARK: Adjust Width
private extension TagView {
    private func _adjustWidth() {
        self.width = self._leftBannerView.width + self._horizontalSpacing + self._label.width + self._deleteButton.width
    }
}


// MARK: Center Views
private extension TagView {
    private func _centerViews() {
        self._leftBannerView.centerVInSuperview()
        self._label.centerVInSuperview()
        self._deleteButton.centerVInSuperview()
    }
}
