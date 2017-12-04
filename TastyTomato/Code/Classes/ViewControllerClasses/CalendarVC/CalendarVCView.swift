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
    var headerView: CalendarHeaderView? {
        get {
            return self._headerView
        }
        set(newHeaderView) {
            self._headerView = newHeaderView
        }
    }
    
    var pageVCView: CalendarDaysView? {
        get {
            return self._pageVCView
        }
        set(newPageVCView) {
            self._pageVCView = newPageVCView
        }
    }
}


// MARK: Class Declaration
class CalendarVCView: UIView {
    // Private Variables
    fileprivate var __headerView: CalendarHeaderView?
    fileprivate var __pageVCView: CalendarDaysView?
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension CalendarVCView {
    var _headerView: CalendarHeaderView? {
        get {
            return self.__headerView
        }
        set(newHeaderView) {
            let oldHeaderView: CalendarHeaderView? = self.__headerView
            guard newHeaderView != oldHeaderView else { return }
            oldHeaderView?.removeFromSuperview()
            if let newHeaderView: CalendarHeaderView = newHeaderView {
                self.addSubview(newHeaderView)
            }
            self.__headerView = newHeaderView
        }
    }
    
    var _pageVCView: CalendarDaysView? {
        get {
            return self.__pageVCView
        }
        set(newPageVCView) {
            let oldPageVCView: CalendarDaysView? = self.__pageVCView
            guard newPageVCView != oldPageVCView else { return }
            oldPageVCView?.removeFromSuperview()
            if let newPageVCView: CalendarDaysView = newPageVCView {
                self.addSubview(newPageVCView)
            }
            self.__pageVCView = newPageVCView
        }
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
        
        self.headerView?.size = CGSize(
            width: width,
            height: headerViewHeight
        )
        
        self.pageVCView?.frame = CGRect(
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
        return 0.3
    }
}
