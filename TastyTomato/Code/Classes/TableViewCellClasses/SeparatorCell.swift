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
    public enum Separator {
        public typealias Insets = (left: CGFloat, right: CGFloat)
        
        public enum Style {
            case top
            case bottom
            case topAndBottom
        }
    }
    
    // Readonly
    public static let defaultTopSeparatorLineWidth: CGFloat = 0.3
    public static let defaultBottomSeparatorLineWidth: CGFloat = 0.3
    
    // ReadWrite
    public var separatorStyle: Separator.Style {
        get { return self._separatorStyle }
        set { self._separatorStyle = newValue }
    }
    
    public var topSeparatorColor: UIColor {
        get { return self._topSeparatorColor }
        set { self._topSeparatorColor = newValue }
    }
    
    public var bottomSeparatorColor: UIColor {
        get { return self._bottomSeparatorColor }
        set { self._bottomSeparatorColor = newValue}
    }
    
    public var topSeparatorLineWidth: CGFloat {
        get { return self._topSeparatorLineWidth }
        set { self._topSeparatorLineWidth = newValue }
    }
    
    public var bottomSeparatorLineWidth: CGFloat {
        get { return self._bottomSeparatorLineWidth }
        set { self._bottomSeparatorLineWidth = newValue }
    }
    
    public var topSeparatorInsets: Separator.Insets {
        get { return self._topSeparatorInsets }
        set { self._topSeparatorInsets = newValue }
    }
    
    public var bottomSeparatorInsets: Separator.Insets {
        get { return self._bottomSeparatorInsets }
        set { self._bottomSeparatorInsets = newValue }
    }
}



// MARK: Class Declaration
open class SeparatorCell: UITableViewCell {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    public override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._init()
    }
    
    // Convenience Init
    public convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    // Common Init
    private func _init() {
        let separatorStyle: Separator.Style = self.separatorStyle
        let layer: CALayer = self.contentView.layer
        if separatorStyle <> [.topAndBottom, .top] {
            layer.addSublayer(self._topSeparator¡)
        }
        
        if separatorStyle <> [.topAndBottom, .bottom] {
            layer.addSublayer(self._bottomSeparator¡)
        }
    }
    
    // Private Lazy Variables
    private lazy var _topSeparator: ALO<LineLayer> = ALO(self._createTopSeparator)
    private lazy var _bottomSeparator: ALO<LineLayer> = ALO(self._createBottomSeparator)
    
    // Private Variables
    private var __separatorStyle: Separator.Style = .bottom
    private var __topSeparatorColor: UIColor = .gray
    private var __bottomSeparatorColor: UIColor = .gray
    private var __topSeparatorInsets: Separator.Insets = (5, 0)
    private var __bottomSeparatorInsets: Separator.Insets = (5, 0)
    private var __topSeparatorLineWidth: CGFloat = SeparatorCell.defaultTopSeparatorLineWidth
    private var __bottomSeparatorLineWidth: CGFloat = SeparatorCell.defaultBottomSeparatorLineWidth
    
    // Layout Overrides
    open override func layoutSublayers(of layer: CALayer) {
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
        return separator
    }
    
    func _createBottomSeparator() -> LineLayer {
        let separator: LineLayer = LineLayer()
        separator.strokeColor = self.bottomSeparatorColor.cgColor
        separator.lineWidth = self.bottomSeparatorLineWidth
        return separator
    }
}


// MARK: Computed Variables
private extension SeparatorCell {
    var _separatorStyle: Separator.Style {
        get { return self.__separatorStyle }
        set(newSeparatorStyle) {
            let oldSeparatorStyle: Separator.Style = self.__separatorStyle
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
            (self._topSeparator¿)?.strokeColor = newTopSeparatorColor.cgColor
        }
    }
    
    var _topSeparatorInsets: Separator.Insets {
        get { return self.__topSeparatorInsets }
        set(newTopSeparatorInsets) {
            guard newTopSeparatorInsets != self.__topSeparatorInsets else { return }
            self.__topSeparatorInsets = newTopSeparatorInsets
            if let topSeparator: LineLayer = self._topSeparator¿ {
                self._adjustLengthOf(
                    separator: topSeparator, totalWidth: self.layer.frame.width, insets: newTopSeparatorInsets
                )
            }
        }
    }
    
    var _topSeparatorLineWidth: CGFloat {
        get { return self.__topSeparatorLineWidth }
        set(newTopSeparatorLineWidth) {
            guard newTopSeparatorLineWidth != self.__topSeparatorLineWidth else { return }
            self.__topSeparatorLineWidth = newTopSeparatorLineWidth
            (self._topSeparator¿)?.lineWidth = newTopSeparatorLineWidth
        }
    }
    
    var _bottomSeparatorColor: UIColor {
        get { return self.__bottomSeparatorColor }
        set(newBottomSeparatorColor) {
            guard newBottomSeparatorColor != self.__bottomSeparatorColor else { return }
            self.__bottomSeparatorColor = newBottomSeparatorColor
            (self._bottomSeparator¿)?.strokeColor = newBottomSeparatorColor.cgColor
        }
    }
    
    var _bottomSeparatorInsets: Separator.Insets {
        get { return self.__bottomSeparatorInsets }
        set(newBottomSeparatorInsets) {
            guard newBottomSeparatorInsets != self.__bottomSeparatorInsets else { return }
            self.__bottomSeparatorInsets = newBottomSeparatorInsets
            if let bottomSeparator: LineLayer = self._bottomSeparator¿ {
                self._adjustLengthOf(
                    separator: bottomSeparator, totalWidth: self.layer.frame.width, insets: newBottomSeparatorInsets
                )
            }
        }
    }
    
    var _bottomSeparatorLineWidth: CGFloat {
        get { return self.__bottomSeparatorLineWidth }
        set(newBottomSeparatorLineWidth) {
            guard newBottomSeparatorLineWidth != self.__bottomSeparatorLineWidth else { return }
            self.__bottomSeparatorLineWidth = newBottomSeparatorLineWidth
            (self._bottomSeparator¿)?.lineWidth = newBottomSeparatorLineWidth
        }
    }
}


// MARK: Layout Override Implementations
private extension SeparatorCell {
    func _layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let width: CGFloat = layer.frame.width
        let height: CGFloat = layer.frame.height
        
        if let topSeparator: LineLayer = self._topSeparator¿ {
            self._adjustLengthOf(
                separator: topSeparator, totalWidth: width, insets: self.topSeparatorInsets
            )
            topSeparator.orthogonalPosition = topSeparator.lineWidth / 2
        }
        
        if let bottomSeparator: LineLayer = self._bottomSeparator¿ {
            self._adjustLengthOf(
                separator: bottomSeparator, totalWidth: width, insets: self.bottomSeparatorInsets
            )
            bottomSeparator.orthogonalPosition = height - (bottomSeparator.lineWidth / 2)
        }
    }
}


// MARK: Helpers
private extension SeparatorCell {
    func _adjustLengthOf(separator: LineLayer, totalWidth: CGFloat, insets: Separator.Insets) {
        let leftInset: CGFloat = insets.left
        separator.length = totalWidth - (leftInset + insets.right)
        separator.parallelPosition = leftInset
    }
}
