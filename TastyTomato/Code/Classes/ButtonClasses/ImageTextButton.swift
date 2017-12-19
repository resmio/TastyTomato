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
    
    var image: UIImage? {
        get {
            return self.imageView?.image
        }
        set(newImage) {
            self.setImage(newImage, for: .normal)
        }
    }
}


// MARK: Class Declaration
public class ImageTextButton: BaseButton {
    // Private Variables
    private var _spacing: CGFloat = 5
    private var _imageAnchoring: ImageAnchoring = .left {
        didSet { self.setNeedsLayout() }
    }
    
    // Layout Overrides
    public override func layoutSubviews() {
        self._layoutSubviews()
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
        let imageIsLeft: Bool = self.imageAnchoring == .left
        let (leftView, rightView): (UIView?, UIView?) =
            imageIsLeft ? (_imageView, _titleLabel) : (_titleLabel, _imageView)
        
        leftView?.centerVInSuperview()
        rightView?.centerVInSuperview()
        
        var titleLabelWidth: CGFloat = width - (2 * inset)
        
        ifLetImageView: if let imageView: UIImageView = _imageView {
            guard imageView.width != 0 else {
                break ifLetImageView
            }
            
            titleLabelWidth -= imageView.width + self._spacing
        }

        _titleLabel?.width = titleLabelWidth

        leftView?.left = inset
        rightView?.right = width - inset
    }
}
