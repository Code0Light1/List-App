//
//  ProductCollectionViewModel.swift
//  EndProductList
//
//  Created by kiranjith on 11/03/2022.
//

import Foundation
import UIKit


enum Section {
    case main
}

protocol Listable {
    associatedtype ListableItem: Hashable
    func listItem(item: ListableItem)
}

class CollectionDataSource<CellType: UICollectionViewCell & Listable>: NSObject {
    
    // Typealiases for our convenience
    typealias Item = CellType.ListableItem
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    private weak var collectionView: UICollectionView?
    
    public var items: Box<[Item]> = .init([])
    
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    init(collectionView: UICollectionView, cellReuseIdentifier: String) {
        self.cellIdentifier = cellReuseIdentifier
        self.collectionView = collectionView
        super.init()
    }
    
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items.value)
        dataSource?.apply(snapshot)
    }
    
    public func add(_ items: [Item]) {
        items.forEach {
            self.items.value.append($0)
        }
        
        update()
    }

}

extension CollectionDataSource {
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellType
        cell.listItem(item: item)
        return cell
    }
    
    public func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { fatalError() }
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        self.dataSource = dataSource
        return dataSource
    }
}


