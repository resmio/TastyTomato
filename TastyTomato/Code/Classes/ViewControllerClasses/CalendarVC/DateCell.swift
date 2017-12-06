//
//  DateCell.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension DateCell {
    var title: String {
        get {
            return self._label.text ?? ""
        }
        set(newTitle) {
            self._label.text = newTitle
        }
    }
    
    var titleColor: UIColor {
        get {
            return self._label.textColor
        }
        set(newTitleColor) {
            self._label.textColor = newTitleColor
        }
    }
}


// MARK: Class Declaration
class DateCell: UICollectionViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self._label)
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self._label)
    }
    
    // Static Constants
    static let reuseIdentifier: String = "DateCellReuseIdentifier"
    
    // Private Lazy Variables
    fileprivate lazy var _label: UILabel = self._createLabel()
    
    // Layout Overrides
    override func layoutSubviews() {
        self._label.size = self.size
    }
    
    // isHighlighted / isSelected Overrides
    override var isHighlighted: Bool {
        get {
            return self._isHighlighted
        }
        set(newIsHighlighted) {
            self._isHighlighted = newIsHighlighted
        }
    }
    
    override var isSelected: Bool {
        get {
            return self._isSelected
        }
        set(newIsSelected) {
            self._isSelected = newIsSelected
        }
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension DateCell {
    func _createLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.text = "31"
        return label
    }
}


// MARK: Computed Variables
private extension DateCell {
    var _isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set(newIsHighlighted) {
            guard newIsHighlighted != super.isHighlighted else { return }
            super.isHighlighted = newIsHighlighted
            self.backgroundColor = newIsHighlighted ? .green : .white
        }
    }
    
    var _isSelected: Bool {
        get {
            return super.isSelected
        }
        set(newIsSelected) {
            guard newIsSelected != super.isSelected else { return }
            super.isSelected = newIsSelected
            self.backgroundColor = newIsSelected ? .green : .white
        }
    }
}
