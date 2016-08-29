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
        self._adjustSize()
    }
    
    // Private Constant Stored Properties
    private let _color: UIColor = UIColor.YellowF8C150()
    private let _backgroundAlpha: CGFloat = 0.5
    private let _label: UILabel = UILabel()
    private let _verticalInset: CGFloat = 10
    private let _horizontalSpacing: CGFloat = 10
    
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
        self._label.font = UIFont.systemFontOfSize(17)
        self._label.textColor = UIColor.Gray555555()
        self._label.sizeToFit()
        
        self.addSubview(self._label)
    }
    
    private func _setupLeftBannerView() {
        self._leftBannerView = UIView(size: CGSize(width: 8, height: self._label.height))
        self._leftBannerView.backgroundColor = self._color
        
        self.addSubview(self._leftBannerView)
    }
    
    private func _setupDeleteButton() {
        let deleteIcon: UIImage = MiscIcon.X.asTemplate()
        let sideLength: CGFloat = self._label.height - 2
        let scaledDeleteIcon: UIImage = deleteIcon.scaledToSize(CGSize(width: sideLength, height: sideLength))
        
        let deleteButtonSideLength: CGFloat = self._label.height + (2 * self._verticalInset)
        let deleteButton: UIButton = UIButton(size: CGSize(width: deleteButtonSideLength, height: deleteButtonSideLength))
        deleteButton.imageView?.image = scaledDeleteIcon
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped_),
            forControlEvents: .TouchUpInside
        )
        
        self.addSubview(self._deleteButton)
    }
}


// MARK: Adjust Size
private extension TagView {
    private func _adjustSize() {
        self.height = self._label.height + (2 * self._verticalInset)
        self._adjustWidth()
    }
    
    private func _adjustWidth() {
        self.width = self._leftBannerView.width + self._horizontalSpacing + self._label.width + self._deleteButton.width
    }
}
