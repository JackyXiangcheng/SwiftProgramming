//
//  ViewController.swift
//  cityTable
//
//  Created by 曹相成 on 2019/5/18.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var citys: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "City Table"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        
        do {
            citys = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New City Info", message: "You can add a city and its information", preferredStyle: .alert)
        
        alert.addTextField{ (textfield: UITextField) -> Void in
            //textfield.placeholder = "input name"
        }
        // 给alertTwo添加第二个输入框
        alert.addTextField{ (textfield: UITextField) -> Void in
            //textfield.placeholder = "input postCode"
        }
        

        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in guard let textField1 = alert.textFields?[0],
                                           let textField2 = alert.textFields?[1],
                                           let textField3 = alert.textFields?[2],
            let nameToSave = textField1.text, let postCodeToSave = textField2.text, let provinceToSave = textField3.text else {
                return
            }
                
                
            self.save(name: nameToSave, postCode: postCodeToSave, province: provinceToSave)
            self.tableView.reloadData()
                
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func save(name: String, postCode: String, province: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)!
        
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        
        city.setValue(name, forKeyPath: "name")
        city.setValue(postCode, forKey: "postCode")
        city.setValue(province,forKey:"province")
        
        do {
            try managedContext.save()
            citys.append(city)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = citys[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
        }
        
        let s2 = String.init(city.value(forKeyPath: "province") as? String ?? "")
        
        cell?.detailTextLabel?.numberOfLines = 2
        cell?.textLabel?.text = city.value(forKeyPath:"name") as? String
        cell?.detailTextLabel?.text = city.value(forKeyPath: "postCode") as? String
        cell?.detailTextLabel?.text?.append("\n"+s2)
        
        return cell!
    }
}

