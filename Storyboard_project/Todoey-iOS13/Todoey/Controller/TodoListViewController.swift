//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory: Category? {
        didSet{ // to specify what should happen when a variable gets set with a new value
            loadItems()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) // where the data is being stored for our current app

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            //Ternary operator ==>
            //value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none // cell.accesoryType 는 item.done이 (true면)checkmark : (false면) none
        }else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems() //commit 이랑 비슷
        
        tableView.deselectRow(at: indexPath, animated: true) // 셀 선택 시 원래는 회색을 유지함, 하지만 이 설정으로 깜빡임 정도로만 보이게 한다
    }
    
    //MARK: - Model Manupulation Methods
    
 
    
    func loadItems() { //READ, Item.fetch.. 이라는 default Value를 주어줌 그래서 loadItem() 이렇게 부르기가능

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //알림메세지
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                }
                }catch{
                    print("Error saving new item, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField //alertTextField 를 밖으로 꺼내 쓰기위해 textField 에 담아준다

        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    


//MARK: - Search bar methods
//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //search버튼 클릭 시,
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //search.text 에 쓴 단어가 포함된 항목을 찾아라!
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // searchBar에 text입력 후 x버튼으로 지웠을 때,
//        if searchBar.text?.count == 0 {
//            loadItems() //다시 원래 List로 돌아옴
//
//            DispatchQueue.main.async { // keyboard가 내려가게 하기위한 명령어 (이 명령이 없으면 그대로 키보드 떠있음)
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}


