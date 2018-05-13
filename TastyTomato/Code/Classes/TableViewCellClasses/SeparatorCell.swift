//
//  SeparatorCell.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 13.05.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


// MARK: // Internal
// MARK: Interface
extension SeparatorCell {
    // SeparatorStyle enum
    enum SeparatorStyle {
        case top
        case bottom
        case topAndBottom
    }
    
    // Readonly
    static let defaultTopSeparatorLineWidth: CGFloat = 0.3
    static let defaultBottomSeparatorLineWidth: CGFloat = 0.3
    
    // ReadWrite
    var separatorStyle: SeparatorStyle {
        get { return self._separatorStyle }
        set { self._separatorStyle = newValue }
    }
    
    var topSeparatorColor: UIColor {
        get { return self._topSeparatorColor }
        set { self._topSeparatorColor = newValue }
    }
    
    var bottomSeparatorColor: UIColor {
        get { return self._bottomSeparatorColor }
        set { self._bottomSeparatorColor = newValue}
    }
    
    var topSeparatorLineWidth: CGFloat {
        get { return self._topSeparatorLineWidth }
        set { self._topSeparatorLineWidth = newValue }
    }
    
    var bottomSeparatorLineWidth: CGFloat {
        get { return self._bottomSeparatorLineWidth }
        set { self._bottomSeparatorLineWidth = newValue }
    }
    
    var topSeparatorInset: CGFloat {
        get { return self._topSeparatorInset }
        set { self._topSeparatorInset = newValue }
    }
    
    var bottomSeparatorInset: CGFloat {
        get { return self._bottomSeparatorInset }
        set { self._bottomSeparatorInset = newValue }
    }
}



// MARK: Class Declaration
class SeparatorCell: UITableViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._init()
    }
    
    // Convenience Init
    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    // Common Init
    private func _init() {
        self._updateTopSeparator()
        self._updateBottomSeparator()
    }
    
    // Private Lazy Variables
    private lazy var _topSeparator: ALO<LineLayer> = ALO(self._createTopSeparator)
    private lazy var _bottomSeparator: ALO<LineLayer> = ALO(self._createBottomSeparator)
    
    // Private Variables
    private var __separatorStyle: SeparatorStyle = .bottom
    private var __topSeparatorColor: UIColor = .gray
    private var __topSeparatorInset: CGFloat = 5
    private var __topSeparatorLineWidth: CGFloat = SeparatorCell.defaultTopSeparatorLineWidth
    private var __bottomSeparatorColor: UIColor = .gray
    private var __bottomSeparatorInset: CGFloat = 5
    private var __bottomSeparatorLineWidth: CGFloat = SeparatorCell.defaultBottomSeparatorLineWidth
    
    // Layout Overrides
    override func layoutSublayers(of layer: CALayer) {
        self._layoutSublayers(of: layer)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension SeparatorCell {
    func _createTopSeparator() -> LineLayer {
        let separator: LineLayer = LineLayer()
        separator.strokeColor = self.topSeparatorColor.cgColor
        separator.lineWidth = self.topSeparatorLineWidth
        separator.parallelPosition = self.topSeparatorInset
        return separator
    }
    
    func _createBottomSeparator() -> LineLayer {
        let separator: LineLayer = LineLayer()
        separator.strokeColor = self.bottomSeparatorColor.cgColor
        separator.lineWidth = self.bottomSeparatorLineWidth
        separator.parallelPosition = self.bottomSeparatorInset
        return separator
    }
}


// MARK: Computed Variables
private extension SeparatorCell {
    var _separatorStyle: SeparatorStyle {
        get { return self.__separatorStyle }
        set(newSeparatorStyle) {
            let oldSeparatorStyle: SeparatorStyle = self.__separatorStyle
            guard newSeparatorStyle != oldSeparatorStyle else { return }
            self.__separatorStyle = newSeparatorStyle
            
            let addSeparator: (inout ALO<LineLayer>) -> Void = {
                self.contentView.layer.addSublayer($0¡)
            }
            
            let removeSeparator: (inout ALO<LineLayer>) -> Void = {
                ($0¿)?.removeFromSuperlayer()
                $0.clear()
            }
            
            switch (oldSeparatorStyle, newSeparatorStyle) {
            case (.top, .topAndBottom): addSeparator(&self._bottomSeparator)
            case (.bottom, .topAndBottom): addSeparator(&self._topSeparator)
            case (_, .top): removeSeparator(&self._bottomSeparator)
            case (_, .bottom): removeSeparator(&self._topSeparator)
            // The next case will never be executed, since we guard against
            // equality of old and new value at the beginning of this setter
            case (.topAndBottom, .topAndBottom): break
            }
        }
    }
    
    var _topSeparatorColor: UIColor {
        get { return self.__topSeparatorColor }
        set(newTopSeparatorColor) {
            guard newTopSeparatorColor != self.__topSeparatorColor else { return }
            self.__topSeparatorColor = newTopSeparatorColor
            self._updateTopSeparator(color: newTopSeparatorColor)
        }
    }
    
    var _topSeparatorInset: CGFloat {
        get { return self.__topSeparatorInset }
        set(newTopSeparatorInset) {
            guard newTopSeparatorInset != self.__topSeparatorInset else { return }
            self.__topSeparatorInset = newTopSeparatorInset
            self._updateTopSeparator(inset: newTopSeparatorInset)
        }
    }
    
    var _topSeparatorLineWidth: CGFloat {
        get { return self.__topSeparatorLineWidth }
        set(newTopSeparatorLineWidth) {
            guard newTopSeparatorLineWidth != self.__topSeparatorLineWidth else { return }
            self.__topSeparatorLineWidth = newTopSeparatorLineWidth
            self._updateTopSeparator(lineWidth: newTopSeparatorLineWidth)
        }
    }
    
    var _bottomSeparatorColor: UIColor {
        get { return self.__bottomSeparatorColor }
        set(newBottomSeparatorColor) {
            guard newBottomSeparatorColor != self.__bottomSeparatorColor else { return }
            self.__bottomSeparatorColor = newBottomSeparatorColor
            self._updateBottomSeparator(color: newBottomSeparatorColor)
        }
    }
    
    var _bottomSeparatorInset: CGFloat {
        get { return self.__bottomSeparatorInset }
        set(newBottomSeparatorInset) {
            guard newBottomSeparatorInset != self.__bottomSeparatorInset else { return }
            self.__bottomSeparatorInset = newBottomSeparatorInset
            self._updateBottomSeparator(inset: newBottomSeparatorInset)
        }
    }
    
    var _bottomSeparatorLineWidth: CGFloat {
        get { return self.__bottomSeparatorLineWidth }
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
        
        if let topSeparator: LineLayer = self._topSeparator¿ {
            let inset: CGFloat = self.topSeparatorInset
            topSeparator.length = width - inset
            topSeparator.parallelPosition = inset
            topSeparator.orthogonalPosition = topSeparator.lineWidth / 2
        }
        
        if let bottomSeparator: LineLayer = self._bottomSeparator¿ {
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
    private func _updateSeparator(_ separator: inout ALO<LineLayer>, color: UIColor, lineWidth: CGFloat, inset: CGFloat) {
        guard color != .clear && lineWidth > 0 else {
            self._removeSeparator(&separator)
            return
        }
        
        if let _separator: LineLayer = separator¿ {
            _separator.strokeColor = color.cgColor
            _separator.lineWidth = lineWidth
            _separator.parallelPosition = inset
        } else {
            self.contentView.layer.addSublayer(separator¡)
        }
    }
    
    private func _removeSeparator(_ separator: inout ALO<LineLayer>) {
        (separator¿)?.removeFromSuperlayer()
        separator.clear()
    }
}
