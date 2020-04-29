//
//  SwipeTableViewController.swift
//  VisionBoard
//
//  Created by Ángeles Vázquez Parra on 29/04/2020.
//  Copyright © 2020 Ángeles Vázquez Parra. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    
    func updateModel(at indexPath: IndexPath){
        //Update your model
    }
    
    //MARK - TableView Datasource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    //MARK - SwipeTableView Methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.updateModel(at: indexPath)
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
