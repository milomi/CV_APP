//
//  UIViewController+CellAnimations.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import Foundation
import UIKit

extension UIViewController {
    
    func animateCellsWithTitleCell(_ tableView: UITableView, afterAnimations: (() -> ())? = nil) {
        let tableHeight: CGFloat =  tableView.bounds.size.height
        tableView.reloadData()
        let cells = tableView.visibleCells
        tableView.isScrollEnabled = false
        
        transformCells(cells, tableHeight: tableHeight)
        
        animateFirstCell(cells.first as? TitleCell, completion: {
            self.animateOtherCells(cells, afterAnimations: {
                if let afterAnimations = afterAnimations {
                    afterAnimations()
                }
                tableView.isScrollEnabled = true
            })
        })
        
    }
    
    func animateViewFadeIn(view: UIView) {
        view.alpha = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, animations: {
                view.alpha = 1
            })
        }
    }
    
    func animateGradientBackgound(color: UIColor) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.superview?.updateGradient(topColor: color)
        })
    }
    
    func animateViewFadeOut(view: UIView) {
        view.alpha = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
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
    
    fileprivate func transformCells(_ cells: [UITableViewCell], tableHeight: CGFloat) {
        cells.forEach { (cell) in
            if cell is TitleCell { } else {
                let cell: UITableViewCell = cell as UITableViewCell
                cell.transform = CGAffineTransform.init(translationX: 0, y: tableHeight)
            }
        }
    }
    
    fileprivate func animateOtherCells(_ cells: [UITableViewCell], afterAnimations: (()->())? = nil) {
        var index = 0
        var completedAnimations = 0
        cells.forEach { (cell) in
            let cell: UITableViewCell = cell as UITableViewCell
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
    
    fileprivate func animateFirstCell(_ cell: TitleCell?, completion: @escaping (() -> ()) ) {
        
        guard let cell = cell, let animatedText = cell.mainView.label.text else {
            print("could not get first cell")
            return
        }
        cell.mainView.label.text = ""
        
        for (index, character) in animatedText.characters.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.07 * Double(index)) {
                cell.mainView.label.text?.append(character)
                if index + 1 == animatedText.characters.count {
                    completion()
                }
            }
        }
        
    }
    
}
