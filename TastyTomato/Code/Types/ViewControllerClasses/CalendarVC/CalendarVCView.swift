//
//  CalendarVCView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
extension CalendarVCView {
    var headerView: CalendarHeaderView {
        return self._headerView
    }
    
    var pageVCContainerView: UIView {
        return self._pageVCContainerView
    }
}


// MARK: Class Declaration
class CalendarVCView: UIView {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self._addSubviews()
        self.setColorAdjustment({ $0.backgroundColor = ColorScheme.background.default })
    }
    
    // Private Lazy Variables
    fileprivate lazy var _headerView: CalendarHeaderView = self._createHeaderView()
    fileprivate lazy var _pageVCContainerView: UIView = UIView()
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarVCView {
    func _createHeaderView() -> CalendarHeaderView {
        let headerView: CalendarHeaderView = CalendarHeaderView()
        headerView.isExclusiveTouch = true
        return headerView
    }
}

// MARK: Layout Override Implementations
private extension CalendarVCView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGSize = self.size
        self.headerView.size = CGSize(
            width: size.width,
            height: size.height * self._headerViewHeightRatio
        )
        
        self._pageVCContainerView.size = size
    }
    
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let numOfHeightUnits: CGFloat = 6
        let numOfWidthUnits: CGFloat = 7
        
        let widthToHeightRatio: CGFloat = self._widthToHeightRatio
        let widthUnit: CGFloat = size.width / numOfWidthUnits
        let heightUnit: CGFloat = (size.height / numOfHeightUnits) / widthToHeightRatio
        var unit: CGFloat = min(widthUnit, heightUnit)
        if unit == 0 {
            unit = max(widthUnit, heightUnit)
        }
        let width: CGFloat = numOfWidthUnits * unit
        let height: CGFloat = numOfHeightUnits * unit
        
        return CGSize(width: width, height: height)
    }
    
    // Private Helpers
    private var _widthToHeightRatio: CGFloat {
        return 1.2
    }
    
    private var _headerViewHeightRatio: CGFloat {
        return 0.25
    }
}


// MARK: Add Subviews
private extension CalendarVCView {
    func _addSubviews() {
        // Order matters here, since we want the gradientLayer of
        // the headerView to be above the pageVCContainerView
        self.addSubview(self._pageVCContainerView)
        self.addSubview(self._headerView)
    }
}
