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
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension DateCell {
    func _createLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.text = "31"
        label.sizeToFit()
        return label
    }
}
