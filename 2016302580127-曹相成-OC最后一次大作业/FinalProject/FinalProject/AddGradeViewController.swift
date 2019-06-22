//
//  AddGradeViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/3.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData


class AddGradeViewController: UIViewController {
    
    @IBOutlet var politicsG: UITextField!
    
    @IBOutlet var ChineseG: UITextField!
    
    @IBOutlet var mathG: UITextField!
    
    @IBOutlet var EnglishG: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBAction func pressBack(_ sender:UIButton){
        self.performSegue(withIdentifier: "toGradeQuery", sender: "")
    }
    @IBAction func submit(_ sender:UIButton){
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        //use delegate
        let newStu:Grade = NSEntityDescription.insertNewObject(forEntityName: "Grade", into: managedObjectContext) as! Grade
        
        let request = NSFetchRequest<Grade>(entityName: "Grade")
        let entity = NSEntityDescription.entity(forEntityName: "Grade", in: managedObjectContext)
        request.predicate = NSPredicate(format: "name = '\(name.text)'", "")
        do{
            let results:[Grade]? = try managedObjectContext.fetch(request)
            if(results!.isEmpty){
                newStu.name = name.text
                newStu.politics =  (politicsG.text as! NSString).intValue
                newStu.chinese = (ChineseG.text as! NSString).intValue
                newStu.math = (mathG.text as! NSString).intValue
                newStu.english = (EnglishG.text as! NSString).intValue
                do{
                    // 插入实体对象
                    try managedObjectContext.save()
                    print("Success to save data.")
                } catch{
                    print("Failed to save data.")
                }
                let alertController = UIAlertController(title: "提示",
                                                        message: "添加成功！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                    action in
                    //切换到前面的页面
                    self.performSegue(withIdentifier: "toGradeQuery",  sender: "")
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                let alertController = UIAlertController(title: "提示",
                                                        message: "该用户名已存在！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                    action in
                    print("点击了确定")
                })
                alertController.addAction(okAction)
            }
        }catch{
            print("Failed to fetch data.")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        name.placeholder = "请输入学生姓名"
        politicsG.placeholder = "请输入学生政治成绩"
        ChineseG.placeholder = "请输入学生语文成绩"
        mathG.placeholder = "请输入学生数学课程成绩"
        EnglishG.placeholder = "请输入学生英语课程成绩"
        // Do any additional setup after loading the view.
    }
    

}
