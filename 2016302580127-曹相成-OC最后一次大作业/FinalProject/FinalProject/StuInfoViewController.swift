//
//  ViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/2.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData
class StuInfoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var sname:NSMutableArray?//存储学生最关键的姓名

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sname?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = sname![indexPath.row] as? String
        return cell
    }
    @IBAction func pressAdd(_ sender:UIButton){
        self.performSegue(withIdentifier: "addStu", sender: "")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //跳转,传递姓名
        self.performSegue(withIdentifier: "detail", sender: sname![indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let controller = segue.destination as! DetailsViewController
            controller.sname = sender as? String
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    @IBAction func pressSearch(_ sender:UIButton){
        let content:String? = searchBar.text
        //跳转
        self.performSegue(withIdentifier: "detail", sender: content)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sname = NSMutableArray.init();
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stu")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            let stuList = try managedObjectContext.fetch(fetchRequest)as! [Stu]
            for s:Stu in stuList{
                let myName = s.name!
                print(myName)
                sname?.add(myName)//初始化学生名单
                print(s.name!)
                
            }
            print("初始化成功")
        }catch{
            print("读取失败")
        }
    }

    

}

