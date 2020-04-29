//
//  ViewController.swift
//  VisionBoard
//
//  Created by Ángeles Vázquez Parra on 29/04/2020.
//  Copyright © 2020 Ángeles Vázquez Parra. All rights reserved.
//

import UIKit
import RealmSwift

class VisionBoardViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var myVisionBoards : Results<VisionBoard>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        
    }
    @IBAction func addVisionBoardPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Vision Board", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newVisionBoard = VisionBoard()
            newVisionBoard.title = textField.text!
            
            self.save(visionBoard: newVisionBoard)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Manipulate object CRUD
    func save(visionBoard: VisionBoard){
        do{
            try realm.write{
                realm.add(visionBoard)
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    func load(){
        myVisionBoards = realm.objects(VisionBoard.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let visionBoardForDeletion = self.myVisionBoards?[indexPath.row] {
            do{
                try self.realm.write{
                    self.realm.delete(visionBoardForDeletion)
                    print("Item deleted")
                }
            }catch{
                print(error)
            }
        }
    }
    
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myVisionBoards?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel!.text = myVisionBoards?[indexPath.row].title
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToGoals", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! GoalViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedVisionBoard = myVisionBoards?[indexPath.row]
        }
    }
}

