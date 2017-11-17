//
//  UIViewController+Animate.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

extension UIViewController {
    
    func animateCells(_ tableView: UITableView, afterAnimations: (() -> ())? = nil) {
        let tableHeight: CGFloat =  tableView.bounds.size.height
        tableView.alpha = 1.0
        tableView.reloadData()
        let cells = tableView.visibleCells
        tableView.isScrollEnabled = false
        
        transformCells(cells, tableHeight: tableHeight)
        
        
        self.animateOtherCells(cells, afterAnimations: {
            if let afterAnimations = afterAnimations {
                afterAnimations()
            }
            tableView.isScrollEnabled = true
        })
        
    }
    
    func animateCollectionViewCells(_ collectionView: UICollectionView) {
        let cells = collectionView.visibleCells
        let collectionHeight = collectionView.bounds.size.height
        transformCells(cells, tableHeight: collectionHeight)
        collectionView.alpha = 1
        animateOtherCells(cells)
    }
    
    func animateViewFadeIn(view: UIView) {
        view.alpha = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, animations: {
                view.alpha = 1
            })
        }
    }
    
    func animateCellsFadeOut(tableView: UITableView, completion: @escaping (() -> ())) {
        let cells =  tableView.visibleCells
        
        DispatchQueue.main.async {
            self.animateSingleCellFadeOut(cells: cells, completion: completion)
        }
        
    }
    
    fileprivate func animateSingleCellFadeOut(cells: [UITableViewCell], completion: @escaping (() -> ()), index: Int = 0) {
        if index == cells.count {
            completion()
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                cells[index].alpha = 0
                cells[index].transform = CGAffineTransform.init(translationX: -100, y: 0)
            }, completion: {
                (completed) in
                cells[index].transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.animateSingleCellFadeOut(cells: cells, completion: completion, index: index + 1)
            })
        }
        
        
    }
    
    fileprivate func transformCells(_ cells: [UIView], tableHeight: CGFloat) {
        cells.forEach { (cell) in
            cell.transform = CGAffineTransform.init(translationX: 0, y: tableHeight)
        }
        
    }
    
    fileprivate func animateOtherCells(_ cells: [UIView], afterAnimations: (() -> ())? = nil) {
        var index = 0
        var completedAnimations = 0
        cells.forEach { (cell) in
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }, completion: {
                completed in
                if let afterAnimations = afterAnimations, completed, completedAnimations == cells.count - 1 {
                    afterAnimations()
                } else if completed {
                    completedAnimations += 1
                }
            })
            index += 1
        }
    }
    
    
}
