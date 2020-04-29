//
//  GoalViewController.swift
//  VisionBoard
//
//  Created by Ángeles Vázquez Parra on 29/04/2020.
//  Copyright © 2020 Ángeles Vázquez Parra. All rights reserved.
//

import UIKit
import RealmSwift

class GoalViewController: SwipeTableViewController {
    
    var goals : Results<Goal>?
    let realm = try! Realm()
    
    var selectedVisionBoard: VisionBoard?{
        didSet{
            loadGoals()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addGoalPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Goal", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentVisionBoard = self.selectedVisionBoard {
                do{
                    try self.realm.write{
                        let newGoal = Goal()
                        newGoal.title = textField.text!
                        currentVisionBoard.goals.append(newGoal)
                    }
                }catch{
                    print(error)
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Manipulate Goal objct CRUD
    func loadGoals(){
        goals = selectedVisionBoard?.goals.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let goalForDeletion = self.goals?[indexPath.row] {
            do{
                try self.realm.write{
                    self.realm.delete(goalForDeletion)
                    print("Item deleted")
                }
            }catch{
                print(error)
            }
        }
    }
    
    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel!.text = goals?[indexPath.row].title
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "goToGoals", sender: self)
    }
}
