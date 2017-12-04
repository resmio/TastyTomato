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
protocol CalendarDaysViewDelegate: class {}


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
}


// MARK: Class Declaration
class CalendarDaysView: UIView {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self._collectionView)
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self._collectionView)
    }
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysViewDelegate?
    
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
extension CalendarDaysView: UICollectionViewDelegate {
    
}


// MARK: UICollectionViewDataSource
extension CalendarDaysView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateCell.reuseIdentifier,
            for: indexPath
        ) as! DateCell
        return cell
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarDaysView {
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


// MARK: Layout Override Implementations
private extension CalendarDaysView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let itemWidth: CGFloat = self.width / 7
        let itemHeight: CGFloat = self.height / 6
        
        let layout: UICollectionViewFlowLayout = self._collectionViewLayout
        let oldItemSize: CGSize = layout.itemSize
        let newItemSize: CGSize = CGSize(width: itemWidth, height: itemHeight)
        if oldItemSize != newItemSize {
            layout.itemSize = newItemSize
            layout.invalidateLayout()
        }
        
        self._collectionView.size = self.size
    }
}
