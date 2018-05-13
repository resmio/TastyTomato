//
//  SeparatorCell.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 13.05.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension SeparatorCell {
    // SeparatorStyle enum
    enum SeparatorStyle: Int {
        case top
        case bottom
        case topAndBottom
    }
    
    // Readonly
    static var defaultTopSeparatorLineWidth: CGFloat {
        return 0.3
    }
    
    static var defaultBottomSeparatorLineWidth: CGFloat {
        return 0.3
    }
    
    // ReadWrite
    var separatorStyle: SeparatorStyle {
        get {
            return self._separatorStyle
        }
        set(newSeparatorStyle) {
            self._separatorStyle = newSeparatorStyle
        }
    }
    
    var topSeparatorColor: UIColor {
        get {
            return self._topSeparatorColor
        }
        set(newTopSeparatorColor) {
            self._topSeparatorColor = newTopSeparatorColor
        }
    }
    
    var bottomSeparatorColor: UIColor {
        get {
            return self._bottomSeparatorColor
        }
        set(newBottomSeparatorColor) {
            self._bottomSeparatorColor = newBottomSeparatorColor
        }
    }
    
    var topSeparatorLineWidth: CGFloat {
        get {
            return self._topSeparatorLineWidth
        }
        set(newTopSeparatorLineWidth) {
            self._topSeparatorLineWidth = newTopSeparatorLineWidth
        }
    }
    
    var bottomSeparatorLineWidth: CGFloat {
        get {
            return self._bottomSeparatorLineWidth
        }
        set(newBottomSeparatorLineWidth) {
            self._bottomSeparatorLineWidth = newBottomSeparatorLineWidth
        }
    }
    
    var topSeparatorInset: CGFloat {
        get {
            return self._topSeparatorInset
        }
        set(newTopSeparatorInset) {
            self._topSeparatorInset = newTopSeparatorInset
        }
    }
    
    var bottomSeparatorInset: CGFloat {
        get {
            return self._bottomSeparatorInset
        }
        set(newBottomSeparatorInset) {
            self._bottomSeparatorInset = newBottomSeparatorInset
        }
    }
}



// MARK: Class Declaration
class SeparatorCell: UITableViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("SeparatorCell does not support NSCoding")
    }
    
    // Override Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._updateTopSeparator()
        self._updateBottomSeparator()
    }
    
    // Convenience Init
    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    // Private Variables
    fileprivate var _topSeparator: LineLayer?
    fileprivate var _bottomSeparator: LineLayer?
    fileprivate var __separatorStyle: SeparatorStyle = .bottom
    fileprivate var __topSeparatorColor: UIColor = .gray
    fileprivate var __topSeparatorInset: CGFloat = 5
    fileprivate var __topSeparatorLineWidth: CGFloat = SeparatorCell.defaultTopSeparatorLineWidth
    fileprivate var __bottomSeparatorColor: UIColor = .gray
    fileprivate var __bottomSeparatorInset: CGFloat = 5
    fileprivate var __bottomSeparatorLineWidth: CGFloat = SeparatorCell.defaultBottomSeparatorLineWidth
    
    
    // Layout Overrides
    override func layoutSublayers(of layer: CALayer) {
        self._layoutSublayers(of: layer)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension SeparatorCell {
    var _separatorStyle: SeparatorStyle {
        get {
            return self.__separatorStyle
        }
        set(newSeparatorStyle) {
            guard newSeparatorStyle != self.__separatorStyle else { return }
            self.__separatorStyle = newSeparatorStyle
            self._updateTopSeparator()
            self._updateBottomSeparator()
        }
    }
    
    var _topSeparatorColor: UIColor {
        get {
            return self.__topSeparatorColor
        }
        set(newTopSeparatorColor) {
            guard newTopSeparatorColor != self.__topSeparatorColor else { return }
            self.__topSeparatorColor = newTopSeparatorColor
            self._updateTopSeparator(color: newTopSeparatorColor)
        }
    }
    
    var _topSeparatorInset: CGFloat {
        get {
            return self.__topSeparatorInset
        }
        set(newTopSeparatorInset) {
            guard newTopSeparatorInset != self.__topSeparatorInset else { return }
            self.__topSeparatorInset = newTopSeparatorInset
            self._updateTopSeparator(inset: newTopSeparatorInset)
        }
    }
    
    var _topSeparatorLineWidth: CGFloat {
        get {
            return self.__topSeparatorLineWidth
        }
        set(newTopSeparatorLineWidth) {
            guard newTopSeparatorLineWidth != self.__topSeparatorLineWidth else { return }
            self.__topSeparatorLineWidth = newTopSeparatorLineWidth
            self._updateTopSeparator(lineWidth: newTopSeparatorLineWidth)
        }
    }
    
    var _bottomSeparatorColor: UIColor {
        get {
            return self.__bottomSeparatorColor
        }
        set(newBottomSeparatorColor) {
            guard newBottomSeparatorColor != self.__bottomSeparatorColor else { return }
            self.__bottomSeparatorColor = newBottomSeparatorColor
            self._updateBottomSeparator(color: newBottomSeparatorColor)
        }
    }
    
    var _bottomSeparatorInset: CGFloat {
        get {
            return self.__bottomSeparatorInset
        }
        set(newBottomSeparatorInset) {
            guard newBottomSeparatorInset != self.__bottomSeparatorInset else { return }
            self.__bottomSeparatorInset = newBottomSeparatorInset
            self._updateBottomSeparator(inset: newBottomSeparatorInset)
        }
    }
    
    var _bottomSeparatorLineWidth: CGFloat {
        get {
            return self.__bottomSeparatorLineWidth
        }
        set(newBottomSeparatorLineWidth) {
            guard newBottomSeparatorLineWidth != self.__bottomSeparatorLineWidth else { return }
            self.__bottomSeparatorLineWidth = newBottomSeparatorLineWidth
            self._updateBottomSeparator(lineWidth: newBottomSeparatorLineWidth)
        }
    }
}


// MARK: View Lifecycle Override Implementations
private extension SeparatorCell {
    func _layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let width: CGFloat = layer.frame.width
        let height: CGFloat = layer.frame.height
        
        if let topSeparator: LineLayer = self._topSeparator {
            let inset: CGFloat = self.topSeparatorInset
            topSeparator.length = width - inset
            topSeparator.parallelPosition = inset
            topSeparator.orthogonalPosition = topSeparator.lineWidth / 2
        }
        
        if let bottomSeparator: LineLayer = self._bottomSeparator {
            let inset: CGFloat = self._bottomSeparatorInset
            bottomSeparator.length = width - inset
            bottomSeparator.parallelPosition = inset
            bottomSeparator.orthogonalPosition = height - (bottomSeparator.lineWidth / 2)
        }
    }
}


// MARK: Update Separators
private extension SeparatorCell {
    func _updateTopSeparator(color: UIColor? = nil, lineWidth: CGFloat? = nil, inset: CGFloat? = nil) {
        guard self.separatorStyle != .bottom else {
            self._removeSeparator(&self._topSeparator)
            return
        }
        
        self._updateSeparator(
            &self._topSeparator,
            color: color ?? self.topSeparatorColor,
            lineWidth: lineWidth ?? self.topSeparatorLineWidth,
            inset: inset ?? self.topSeparatorInset
        )
    }
    
    func _updateBottomSeparator(color: UIColor? = nil, lineWidth: CGFloat? = nil, inset: CGFloat? = nil) {
        guard self.separatorStyle != .top else {
            self._removeSeparator(&self._bottomSeparator)
            return
        }
        
        self._updateSeparator(
            &self._bottomSeparator,
            color: color ?? self.bottomSeparatorColor,
            lineWidth: lineWidth ?? self.bottomSeparatorLineWidth,
            inset: inset ?? self.bottomSeparatorInset
        )
    }
    
    // Private Helpers
    private func _updateSeparator(_ separator: inout LineLayer?, color: UIColor, lineWidth: CGFloat, inset: CGFloat) {
        guard color != .clear && lineWidth > 0 else {
            self._removeSeparator(&separator)
            return
        }
        
        let _separator: LineLayer = separator ?? LineLayer()
        _separator.strokeColor = color.cgColor
        _separator.lineWidth = lineWidth
        _separator.parallelPosition = inset
        
        if separator == nil {
            separator = _separator
            self.contentView.layer.addSublayer(_separator)
        }
    }
    
    private func _removeSeparator(_ separator: inout LineLayer?) {
        separator?.removeFromSuperlayer()
        separator = nil
    }
}
