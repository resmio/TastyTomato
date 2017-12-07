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
    
    var pageVCViewContainer: UIView {
        return self._pageVCViewContainer
    }
}


// MARK: Class Declaration
class CalendarVCView: UIView {
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
    fileprivate lazy var _headerView: CalendarHeaderView = self._createHeaderView()
    fileprivate lazy var _pageVCViewContainer: UIView = self._createPageVCViewContainer()
    
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
    
    func _createPageVCViewContainer() -> UIView {
        let pageVCViewContainer: UIView = UIView()
        pageVCViewContainer.isExclusiveTouch = true
        return pageVCViewContainer
    }
}

// MARK: Layout Override Implementations
private extension CalendarVCView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGSize = self.sizeThatFits(self.size)
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        
        let headerViewHeight: CGFloat = height * self._headerViewHeightRatio
        let pageVCViewHeight: CGFloat = height - headerViewHeight
        
        self.headerView.size = CGSize(
            width: width,
            height: headerViewHeight
        )
        
        self.pageVCViewContainer.frame = CGRect(
            x: 0,
            y: headerViewHeight,
            width: width,
            height: pageVCViewHeight
        )
    }
    
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let numOfHeightUnits: CGFloat = 6
        let numOfWidthUnits: CGFloat = 7
        
        let widthToHeightRatio: CGFloat = self._widthToHeightRatio
        let widthUnit: CGFloat = size.width / numOfWidthUnits
        let heightUnit: CGFloat = (size.height / numOfHeightUnits) / widthToHeightRatio
        let smallerUnit: CGFloat = min(widthUnit, heightUnit)
        let width: CGFloat = numOfWidthUnits * smallerUnit
        let height: CGFloat = numOfHeightUnits * smallerUnit
        
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
        self.addSubview(self._headerView)
        self.addSubview(self._pageVCViewContainer)
    }
}
