//
//  TagView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: - TagViewDelegate
@objc public protocol TagViewDelegate: class {
    func deleteButtonTapped(on tagView: TagView)
}


// MARK: - TagView
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
    
    public var showsDeleteButton: Bool {
        get {
            return self._showsDeleteButton
        }
        set(newShowsDeleteButton) {
            self._showsDeleteButton = newShowsDeleteButton
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
        super.init(frame: CGRect(size: CGSize(height: TagView.defaultHeight)))
        
        let label: UILabel = self._label
        label.text = name
        label.size.width = label.sizeThatFits(.zero).width
        
        let layer: CALayer = self.layer
        layer.cornerRadius = 4
        layer.borderWidth = 1
        self.clipsToBounds = true
        
        self._addSubviews()
        self.sizeToFit()
        
        self._setColor(self._defaultColor, temporary: false)
    }
    
    // Internal Static Constants
    internal static let defaultHeight: CGFloat = 35.5
    
    // Private Static Constants
    fileprivate static let _labelHeight: CGFloat = 20
    fileprivate static let _leftBannerWidth: CGFloat = 8
    fileprivate static let _backgroundAlpha: CGFloat = 0.1
    fileprivate static let _horizontalSpacing: CGFloat = 10
    fileprivate static let _fontSize: CGFloat = 16
    fileprivate static let _deleteIconSideLength: CGFloat = 15
    
    // Private Weak Variables
    fileprivate weak var _delegate: TagViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _leftBannerView: UIView = self._createLeftBannerView()
    fileprivate lazy var _label: UILabel = self._createLabel()
    
    // Private Variables
    fileprivate var _defaultColor: UIColor = .yellowF8C150
    fileprivate var __deleteButton: UIButton?
    fileprivate var __showsDeleteButton: Bool = false
    
    
    // Layout Overrides
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension TagView {
    func _createLeftBannerView() -> UIView {
        let leftBannerView: UIView = UIView(size:
            CGSize(width: TagView._leftBannerWidth, height: TagView.defaultHeight)
        )
        leftBannerView.backgroundColor = self._defaultColor
        leftBannerView.vCenter = TagView.defaultHeight / 2
        return leftBannerView
    }
    
    func _createLabel() -> UILabel {
        let label: UILabel = UILabel(size: CGSize(height: TagView._labelHeight))
        label.font = .systemFont(ofSize: TagView._fontSize)
        label.textColor = .gray555555
        label.vCenter = TagView.defaultHeight / 2
        label.left = self._leftBannerView.right + TagView._horizontalSpacing
        return label
    }
}


// MARK: Computed Variables
private extension TagView {
    var _deleteButton: UIButton {
        return self.__deleteButton ?? {
            let deleteButtonSideLength: CGFloat = self.height
            let deleteButton: UIButton = UIButton(size:
                CGSize(width: deleteButtonSideLength, height: deleteButtonSideLength)
            )
            
            let scaledDeleteIcon: UIImage = MiscIcon.X.asTemplate().scaledToSize(
                CGSize(width: TagView._deleteIconSideLength, height: TagView._deleteIconSideLength)
            )
            deleteButton.setImage(scaledDeleteIcon, for: .normal)
            deleteButton.tintColor = .gray555555
            
            deleteButton.addTarget(
                self,
                action: #selector(_tappedDeleteButton),
                for: .touchUpInside
            )
            deleteButton.addTarget(
                self,
                action: #selector(_touchedDownOnDeleteButton),
                for: .touchDown
            )
            deleteButton.addTarget(
                self,
                action: #selector(_resetColor),
                for: .touchDragExit
            )
            deleteButton.addTarget(
                self,
                action: #selector(_resetColor),
                for: .touchCancel
            )
            
            deleteButton.vCenter = TagView.defaultHeight / 2
            deleteButton.left = self._label.right
            self.__deleteButton = deleteButton
            return deleteButton
        }()
    }
    
    var _showsDeleteButton: Bool {
        get {
            return self.__showsDeleteButton
        }
        set(newShowsDeleteButton) {
            guard newShowsDeleteButton != self.__showsDeleteButton else { return }
            self.__showsDeleteButton = newShowsDeleteButton
            self._showDeleteButton(newShowsDeleteButton)
        }
    }
    
    // Private Helper
    private func _showDeleteButton(_ show: Bool) {
        if show {
            self.addSubview(self._deleteButton)
        } else {
            self.__deleteButton?.removeFromSuperview()
            self.__deleteButton = nil
        }
        self.sizeToFit()
    }
}


// MARK: Layout Override Implementations
private extension TagView {
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let width: CGFloat = (
            self._leftBannerView.width +
            TagView._horizontalSpacing +
            self._label.width +
            (self.__deleteButton?.width ?? TagView._horizontalSpacing)
        )
        
        return CGSize(width: width, height: TagView.defaultHeight)
    }
}


// MARK: Add Subviews
private extension TagView {
    func _addSubviews() {
        self.addSubview(self._leftBannerView)
        self.addSubview(self._label)
        
        if self.showsDeleteButton {
            self.addSubview(self._deleteButton)
        }
    }
}


// MARK: Set Color
private extension TagView {
    func _setColor(_ color: UIColor, temporary: Bool) {
        self.backgroundColor = color.withAlpha(TagView._backgroundAlpha)
        self.layer.borderColor = color.cgColor
        self._leftBannerView.backgroundColor = color
        if !temporary {
            self._defaultColor = color
        }
    }
    
    @objc func _resetColor() {
        self._setColor(self._defaultColor, temporary: false)
    }
}


// MARK: Delete Button Target Selectors
private extension TagView {
    @objc func _tappedDeleteButton() {
        self.delegate?.deleteButtonTapped(on: self)
        self._resetColor()
    }
    
    @objc func _touchedDownOnDeleteButton() {
        self._setColor(.redE62C4F, temporary: true)
    }
}
