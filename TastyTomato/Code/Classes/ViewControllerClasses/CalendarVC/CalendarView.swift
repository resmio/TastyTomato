//
//  CalendarView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - CalendarViewDelegate
protocol CalendarViewDelegate: class {}


// MARK: - CalendarView
// MARK: Interface
extension CalendarView {
    var delegate: CalendarViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
}


// MARK: Class Declaration
class CalendarView: UIView {
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
    fileprivate weak var _delegate: CalendarViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _collectionView: UICollectionView = self._createCollectionView()
    fileprivate lazy var _collectionViewLayout: UICollectionViewFlowLayout = self._createCollectionViewLayout()
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: Delegates / DataSources
// MARK: UICollectionViewDelegate
extension CalendarView: UICollectionViewDelegate {
    
}


// MARK: UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeekdayNameCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeekdayNameCell.reuseIdentifier,
            for: indexPath
        ) as! WeekdayNameCell
        cell.title = "Mon"
        return cell
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarView {
    func _createCollectionView() -> UICollectionView {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self._collectionViewLayout
        )
        collectionView.backgroundColor = .white
        
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            WeekdayNameCell.self,
            forCellWithReuseIdentifier: WeekdayNameCell.reuseIdentifier
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


// MARK: Layout Override Implementations
private extension CalendarView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let maxPossibleItemWidth: CGFloat = self.width / 7
        let maxPossibleItemHeight: CGFloat = self.height / 6
        let itemSideLength: CGFloat = min(maxPossibleItemWidth, maxPossibleItemHeight)
        
        let layout: UICollectionViewFlowLayout = self._collectionViewLayout
        let oldItemSize: CGSize = layout.itemSize
        let newItemSize: CGSize = CGSize(width: itemSideLength, height: itemSideLength)
        layout.itemSize = newItemSize
        if oldItemSize != newItemSize {
            layout.invalidateLayout()
        }
        
        let collectionView: UICollectionView = self._collectionView
        let collectionViewWidth: CGFloat = itemSideLength * 7
        let collectionViewHeight: CGFloat = itemSideLength * 6
        collectionView.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        collectionView.centerInSuperview()
    }
}


// MARK: Add Subviews
private extension CalendarView {
    func _addSubviews() {
        self.addSubview(self._collectionView)
    }
}
