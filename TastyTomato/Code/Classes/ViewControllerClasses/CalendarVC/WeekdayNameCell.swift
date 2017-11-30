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
    
    // Static Variables
    static let reuseIdentifier: String = "WeekdayNameCellReuseIdentifier"
    
    // Private Lazy Variables
    fileprivate lazy var _titleLabel: UILabel = self._createTitleLabel()
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension WeekdayNameCell {
    func _createTitleLabel() -> UILabel {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Mon" // FIXME: Remove
        titleLabel.textAlignment = .center
        return titleLabel
    }
}


// MARK: Layout Override Implementations
private extension WeekdayNameCell {
    func _layoutSubviews() {
        super.layoutSubviews()
        self._titleLabel.frame = self.bounds
    }
}


// MARK: Add Subviews
private extension WeekdayNameCell {
    func _addSubviews() {
        self.contentView.addSubview(self._titleLabel)
        
        self.contentView.layer.cornerRadius = 5 // FIXME: Remove
        self.contentView.layer.borderColor = UIColor.black.cgColor // FIXME: Remove
        self.contentView.layer.borderWidth = 1 // FIXME: Remove
    }
}
