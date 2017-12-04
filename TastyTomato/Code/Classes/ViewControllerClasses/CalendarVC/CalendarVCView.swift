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
    var headerView: UIView? {
        get {
            return self._headerView
        }
        set(newHeaderView) {
            self._headerView = newHeaderView
        }
    }
    
    var pageVCView: UIView? {
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
    fileprivate var __headerView: UIView?
    fileprivate var __pageVCView: UIView?
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size: size)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension CalendarVCView {
    var _headerView: UIView? {
        get {
            return self.__headerView
        }
        set(newHeaderView) {
            let oldHeaderView: UIView? = self.__headerView
            guard newHeaderView != oldHeaderView else { return }
            oldHeaderView?.removeFromSuperview()
            if let newHeaderView: UIView = newHeaderView {
                self.addSubview(newHeaderView)
            }
            self.__headerView = newHeaderView
        }
    }
    
    var _pageVCView: UIView? {
        get {
            return self.__pageVCView
        }
        set(newPageVCView) {
            let oldPageVCView: UIView? = self.__pageVCView
            guard newPageVCView != oldPageVCView else { return }
            oldPageVCView?.removeFromSuperview()
            if let newPageVCView: UIView = newPageVCView {
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
        
        let width: CGFloat = self.width
        let heightUnit: CGFloat = self.height / 8
        let headerViewHeight: CGFloat = 2 * heightUnit
        
        self.headerView?.size = CGSize(
            width: width,
            height: headerViewHeight
        )
        
        self.pageVCView?.frame = CGRect(
            x: 0,
            y: headerViewHeight,
            width: width,
            height: 6 * heightUnit
        )
    }
    
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        let widthUnit: CGFloat = size.width / 7
        let heightUnit: CGFloat = size.height / 8
        let smallerUnit: CGFloat = min(widthUnit, heightUnit)
        return CGSize(width: 7 * smallerUnit, height: 8 * smallerUnit)
    }
}
