//
//  CalendarView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - CalendarDaysViewDelegate
protocol CalendarDaysViewDelegate: class {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView)
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView)
}


// MARK: - CalendarView
// MARK: Interface
extension CalendarDaysView {
    var delegate: CalendarDaysViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    var topInset: CGFloat {
        get {
            return self._topInset
        }
        set(newTopInset) {
            self._topInset = newTopInset
        }
    }
    
    var titleLabelFrame: CGRect {
        get {
            return self._titleLabel.frame
        }
        set(newTitleLabelFrame) {
            self._titleLabel.frame = newTitleLabelFrame
        }
    }
    
    var title: String {
        get {
            return self._titleLabel.text ?? ""
        }
        set(newTitle) {
            self._titleLabel.text = newTitle
        }
    }
    
    var titleFont: UIFont {
        get {
            return self._titleLabel.font
        }
        set(newFont) {
            self._titleLabel.font = newFont
        }
    }
    
    var titleColor: UIColor {
        get {
            return self._titleLabel.textColor
        }
        set(newTitleColor) {
            self._titleLabel.textColor = newTitleColor
        }
    }
    
    // Functions
    func selectDateCell(at indexPath: IndexPath?) {
        self._collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    func reloadCells() {
        self._reloadCells()
    }
}


// MARK: Class Declaration
class CalendarDaysView: UIView {
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
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _titleLabel: UILabel = self._createTitleLabel()
    fileprivate lazy var _collectionView: UICollectionView = self._createCollectionView()
    fileprivate lazy var _collectionViewLayout: UICollectionViewFlowLayout = self._createCollectionViewLayout()
    
    // Private Variables
    fileprivate var __topInset: CGFloat = 0
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: Delegates / DataSources
// MARK: UICollectionViewDelegate
extension CalendarDaysView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return self._collectionView(collectionView, shouldHighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self._collectionView(collectionView, didSelectItemAt: indexPath)
    }
}


// MARK: UICollectionViewDataSource
extension CalendarDaysView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self._collectionView(collectionView, cellForItemAt: indexPath)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarDaysView {
    func _createTitleLabel() -> UILabel {
        let titleLabel: UILabel = UILabel()
        titleLabel.setColorAdjustment({ ($0 as? UILabel)?.textColor = ColorScheme.text.titleLabel })
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Monthname Year"
        return titleLabel
    }
    
    func _createCollectionView() -> UICollectionView {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self._collectionViewLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            DateCell.self,
            forCellWithReuseIdentifier: DateCell.reuseIdentifier
        )
        return collectionView
    }
    
    func _createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}


// MARK: Computed Variables
private extension CalendarDaysView {
    var _topInset: CGFloat {
        get {
            return self.__topInset
        }
        set(newTopInset) {
            guard newTopInset != self.__topInset else { return }
            self.__topInset = newTopInset
            self.setNeedsLayout()
        }
    }
}


// MARK: Layout Override Implementations
private extension CalendarDaysView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.width
        let topInset: CGFloat = self.topInset
        let collectionViewHeight: CGFloat = self.height - topInset
        let itemWidth: CGFloat = width / 7
        let itemHeight: CGFloat = collectionViewHeight / 6
        
        let layout: UICollectionViewFlowLayout = self._collectionViewLayout
        let oldItemSize: CGSize = layout.itemSize
        let newItemSize: CGSize = CGSize(width: itemWidth, height: itemHeight)
        if oldItemSize != newItemSize {
            layout.itemSize = newItemSize
            layout.invalidateLayout()
        }
        
        self._collectionView.frame = CGRect(x: 0, y: topInset, width: width, height: collectionViewHeight)
    }
}


// MARK: Add Subviews
private extension CalendarDaysView {
    func _addSubviews() {
        self.addSubview(self._titleLabel)
        self.addSubview(self._collectionView)
    }
}


// MARK: Delegates / DataSources
// MARK: UICollectionViewDelegate
private extension CalendarDaysView/*: UICollectionViewDelegate*/ {
    func _collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell: DateCell = collectionView.cellForItem(at: indexPath) as! DateCell
        return self.delegate?.shouldSelect(cell, at: indexPath, on: self) ?? true
    }
    
    func _collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: DateCell = collectionView.cellForItem(at: indexPath) as! DateCell
        self.delegate?.didSelect(cell, at: indexPath, on: self)
    }
}


// MARK: UICollectionViewDataSource
private extension CalendarDaysView/*: UICollectionViewDataSource*/ {
    func _collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateCell.reuseIdentifier,
            for: indexPath
        ) as! DateCell
        self.delegate?.configure(cell, for: indexPath, on: self)
        return cell
    }
}


// MARK: Reload Cells
private extension CalendarDaysView {
    func _reloadCells() {
        let selectedIndexPath: IndexPath? = self._collectionView.indexPathsForSelectedItems?.first
        self._collectionView.reloadData()
        self._collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
    }
}
