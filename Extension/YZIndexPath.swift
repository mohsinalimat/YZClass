//
//  YZIndexPath.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit

//MARK: - IndexPath Extension(s)
extension IndexPath {
    
    /// It is used to get `IndexPath` from `UITableView`.
    /// - Parameters:
    ///   - view: `UIView` type object to get indexPath, where is located in `UITableView`.
    ///   - tableView: `UITableView` type object to get indexPath.
    /// - Returns: It will return `IndexPath` object.
    public static func indexPathForCellContaining(_ view: UIView, tableView: UITableView) -> IndexPath? {
        let viewCenterRelativeToTableview = tableView.convert(CGPoint(x: view.bounds.midX, y: view.bounds.midY), from:view)
        return tableView.indexPathForRow(at: viewCenterRelativeToTableview)
    }
    
    /// It is used to get `IndexPath` from `UICollectionView`.
    /// - Parameters:
    ///   - view: `UIView` type object to get indexPath, where is located in `UICollectionView`.
    ///   - collectionView: `UICollectionView` type object to get indexPath.
    /// - Returns: It will return `IndexPath` object.
    public static func indexPathForCellContaining(_ view: UIView, collectionView: UICollectionView) -> IndexPath? {
        let viewCenterRelativeToCollview = collectionView.convert(CGPoint(x: view.bounds.midX, y: view.bounds.midY), from:view)
        return collectionView.indexPathForItem(at: viewCenterRelativeToCollview)
    }
}
