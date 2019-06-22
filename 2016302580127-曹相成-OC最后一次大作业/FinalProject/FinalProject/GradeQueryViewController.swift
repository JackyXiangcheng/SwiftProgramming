//
//  GradeQueryViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/3.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData

class GradeQueryViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGDetail"{
            let controller = segue.destination as! GradeDetailViewController
            controller.grade = sender as? Grade
        }
    }
    @IBOutlet weak var input: UISearchBar!
    @IBAction func pressQuery(_ sender:UIButton){
        let sname = input.text
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grade")
        do{
            let gradeList = try managedObjectContext.fetch(fetchRequest)as! [Grade]
            if(gradeList.count != 0){
                for s:Grade in gradeList{
                    if s.name == sname{
                        performSegue(withIdentifier: "toGDetail", sender: s)
                    }
                }

            }
            print("初始化成功")
        }catch{
            print("读取失败")
        }
    }
    
    @IBAction func pressAdd(_ sender:UIButton){
        performSegue(withIdentifier:"addGrade", sender: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.placeholder = "输入要查询的学生姓名"
    }
    

}
