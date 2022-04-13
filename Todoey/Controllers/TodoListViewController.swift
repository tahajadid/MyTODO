//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let actualItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = actualItem.title
        
        // Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = actualItem.done ? .checkmark : .none

        return cell
    }

    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        self.saveItems()

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Items 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            // what wil happen once the user clicks on the add
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"

            textField = alertTextField

        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK - Model Manupaltion Methods
    
    func saveItems(){
        
        do {
            try context.save()
        } catch {
            print("Error saving : \(error)")
        }
        
    }

    
    func loadItems(){

        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Erro in fetchind : \(error)")
        }
    }
    
}

