//
//  WeekdayNameCell.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension WeekdayNameCell {
    var title: String {
        get {
            return self._titleLabel.text ?? ""
        }
        set(newTitle) {
            self._titleLabel.text = newTitle
        }
    }
}


// MARK: Class Declaration
class WeekdayNameCell: UICollectionViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._addSubviews()
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._addSubviews()
    }
    
    // Private Lazy Variables
    fileprivate lazy var _titleLabel: UILabel = self._createTitleLabel()
    
    // Layout Overrides
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension WeekdayNameCell {
    func _createTitleLabel() -> UILabel {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Mon"
        return titleLabel
    }
}


// MARK: Layout Override Implementations
private extension WeekdayNameCell {
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let titleLabel: UILabel = self._titleLabel
        titleLabel.sizeToFit()
        let width: CGFloat = max(size.width, titleLabel.width)
        let height: CGFloat = max(size.height, titleLabel.height)
        return CGSize(width: width, height: height)
    }
}


// MARK: Add Subviews
private extension WeekdayNameCell {
    func _addSubviews() {
        self.contentView.addSubview(self._titleLabel)
    }
}
