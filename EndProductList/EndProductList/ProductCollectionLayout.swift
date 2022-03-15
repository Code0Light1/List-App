//
//  ProductCollectionLayout.swift
//  EndProductList
//
//  Created by kiranjith on 13/03/2022.
//

import Foundation
import UIKit


class ProductCollectionLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    override init() {
         super.init()
         
         let screenWidth = UIScreen.main.bounds.width
        let widthHeightConstant = UIScreen.main.bounds.width / 2.1
         self.itemSize = CGSize(width: widthHeightConstant,
                                height: widthHeightConstant)
         let numberOfCellsInRow = floor(screenWidth / widthHeightConstant)
         let inset = (screenWidth - (numberOfCellsInRow * widthHeightConstant)) / (numberOfCellsInRow + 1)
         self.sectionInset = .init(top: inset,
                                   left: inset,
                                   bottom: inset,
                                   right: inset)
         self.minimumInteritemSpacing = inset
         self.minimumLineSpacing = inset
         self.scrollDirection = .vertical
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

extension ProductCollectionLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
//
//        return CGSize(width: width, height: LayoutConstant.itemHeight)
//    }
//
//    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
//        let itemsInRow: CGFloat = 2
//
//        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
//        let finalWidth = (width - totalSpacing) / itemsInRow
//
//        return floor(finalWidth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return LayoutConstant.spacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return LayoutConstant.spacing
//    }
}
