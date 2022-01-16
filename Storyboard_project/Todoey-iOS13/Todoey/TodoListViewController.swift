//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
   
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark { // 체크마크가 있으면 클릭시 없에고, 없으면 클릭시 생기게
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true) // 셀 선택 시 원래는 회색을 유지함, 하지만 이 설정으로 깜빡임 정도로만 보이게 한다
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //알림메세지
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the clicks the Add Item button on our UIAlert
            
            self.itemArray.append(textField.text!) // itemArray에 append 는 된다 (디버깅으로 브레이크 포인트 잡고 확인함) but showing 이 안됨
            
            self.tableView.reloadData() //이 부분을 통해 show가 가능함
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField //alertTextField 를 밖으로 꺼내 쓰기위해 textField 에 담아준다
            
          
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

 


