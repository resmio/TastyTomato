//
//  CalendarView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: -
protocol CalendarDaysViewDelegate: class {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView)
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView)
}


// MARK: -
// MARK: Interface
extension CalendarDaysView {
    var topInset: CGFloat {
        get { return self._topInset }
        set { self._topInset = newValue }
    }
    
    var titleLabelFrame: CGRect {
        get { return self._titleLabel.frame }
        set { self._titleLabel.frame = newValue }
    }
    
    var title: String {
        get { return self._titleLabel.text ?? "" }
        set { self._titleLabel.text = newValue }
    }
    
    var titleFont: UIFont {
        get { return self._titleLabel.font }
        set { self._titleLabel.font = newValue }
    }
    
    var titleColor: UIColor {
        get { return self._titleLabel.textColor }
        set { self._titleLabel.textColor = newValue }
    }
    
    // Setters
    func setDelegate(_ delegate: CalendarDaysViewDelegate?) {
        self._delegate = delegate
    }
    
    // Functions
    func selectDateCell(at indexPath: IndexPath?) {
        self._selectDateCell(at: indexPath)
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
        self._init()
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        [self._titleLabel, self._collectionView].forEach(self.addSubview)
    }
    
    // Private Weak Variables
    private weak var _delegate: CalendarDaysViewDelegate?
    
    // Private Lazy Variables
    private lazy var _titleLabel: UILabel = self._createTitleLabel()
    private lazy var _collectionView: UICollectionView = self._createCollectionView()
    private lazy var _collectionViewLayout: UICollectionViewFlowLayout = self._createCollectionViewLayout()
    
    // Private Variables
    private var __topInset: CGFloat = 0
    private var _selectedIndexPath: IndexPath?
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: Protocol Conformances
// MARK: UICollectionViewDelegate
extension CalendarDaysView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return self._collectionView(collectionView, shouldSelectItemAt: indexPath)
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


// MARK: Protocol Conformance Implementations
// MARK: UICollectionViewDelegate
private extension CalendarDaysView/*: UICollectionViewDelegate*/ {
    func _collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell: DateCell = collectionView.cellForItem(at: indexPath) as! DateCell
        guard self._delegate?.shouldSelect(cell, at: indexPath, on: self) ?? true else { return false }
        
        if let selectedIndexPath: IndexPath = self._selectedIndexPath {
            collectionView.cellForItem(at: selectedIndexPath)?.isSelected = false
        }
        
        cell.isSelected = true
        self._selectedIndexPath = indexPath
        self._delegate?.didSelect(cell, at: indexPath, on: self)
        return false
    }
}


// MARK: UICollectionViewDataSource
private extension CalendarDaysView/*: UICollectionViewDataSource*/ {
    func _collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateCell.reuseIdentifier,
            for: indexPath
        ) as! DateCell
        self._delegate?.configure(cell, for: indexPath, on: self)
        cell.isSelected = indexPath == self._selectedIndexPath
        return cell
    }
}


// MARK: Interface Implementations
private extension CalendarDaysView {
    func _selectDateCell(at indexPath: IndexPath?) {
        self._selectedIndexPath = indexPath
        self.reloadCells()
    }
    
    func _reloadCells() {
        let selectedIndexPath: IndexPath? = self._collectionView.indexPathsForSelectedItems?.first
        self._collectionView.reloadData()
        self._collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
    }
}
