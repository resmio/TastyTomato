//
//  ImageTextButton.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 19.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension ImageTextButton {
    enum ImageAnchoring {
        case left, right
    }
    
    var imageAnchoring: ImageAnchoring {
        get {
            return self._imageAnchoring
        }
        set(newImageAnchoring) {
            self._imageAnchoring = newImageAnchoring
        }
    }
    
    var text: String {
        get {
            return self.titleLabel?.text ?? ""
        }
        set(newText) {
            self.setTitle(newText)
        }
    }
}


// MARK: Class Declaration
public class ImageTextButton: BaseButton {
    // Private Variables
    private var _spacing: CGFloat = 0
    private var _imageAnchoring: ImageAnchoring = .left {
        didSet { self.setNeedsLayout() }
    }
    
    // Layout Overrides
    public override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
}


// MARK: // Private
// MARK: Layout Override Implementations
private extension ImageTextButton {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.width
        let inset: CGFloat = self.xPadding
        
        let _titleLabel: UILabel? = self.titleLabel
        let _imageView: UIImageView? = self.imageView
        let imageShouldBeLeftAnchored: Bool = self.imageAnchoring == .left
        let (leftView, rightView): (UIView?, UIView?) =
            imageShouldBeLeftAnchored ? (_imageView, _titleLabel) : (_titleLabel, _imageView)
        
        leftView?.sizeToFit()
        rightView?.sizeToFit()
        
        leftView?.centerVInSuperview()
        rightView?.centerVInSuperview()
        
        leftView?.left = 0
        rightView?.right = width
    }
    
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let titleLabel: UILabel = self.titleLabel!
        let imageView: UIImageView = self.imageView!
        
        titleLabel.sizeToFit()
        imageView.sizeToFit()
        
        let height: CGFloat = max(titleLabel.height, imageView.height, size.height)
        let width: CGFloat = titleLabel.width + imageView.width + self._spacing
        
        return CGSize(width: width, height: height)
    }
}


    }
}
