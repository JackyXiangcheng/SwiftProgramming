//
//  AddStuViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/3.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData
class AddStuViewController: UIViewController {
    
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var departmentInput: UITextField!
    
    @IBOutlet weak var snoInput: UITextField!
    
    @IBOutlet weak var phoneInput: UITextField!
    
    @IBOutlet weak var idnumInput: UITextField!
    
    @IBOutlet weak var placeInput: UITextField!
    
    @IBOutlet weak var comInput: UITextField!
    
    @IBAction func pressBack(_ sender:UIButton){
        performSegue(withIdentifier:"submited",sender: "")
    }
    @IBAction func submitInfo(_ sender:UIButton){
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        //use delegate
        let newStu:Stu = NSEntityDescription.insertNewObject(forEntityName: "Stu", into: managedObjectContext) as! Stu
        
        let request = NSFetchRequest<Stu>(entityName: "Stu")
        let entity = NSEntityDescription.entity(forEntityName: "Stu", in: managedObjectContext)
        request.predicate = NSPredicate(format: "name = '\(nameInput.text)'", "")
        do{
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            if(results!.isEmpty){
                newStu.name = nameInput.text
                newStu.sno = snoInput.text
                newStu.dep = departmentInput.text
                newStu.phone = phoneInput.text
                newStu.iDnum = idnumInput.text
                newStu.place = placeInput.text
                newStu.com = comInput.text
                
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
                    self.performSegue(withIdentifier: "submited",  sender: "")
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)

            }else{
                let alertController = UIAlertController(title: "提示",
                                                        message: "该用户已经存在！", preferredStyle: .alert)
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
        
        nameInput.placeholder = "请输入姓名"
        departmentInput.placeholder = "请输入学号"
        snoInput.placeholder = "请输入学院"
        phoneInput.placeholder = "请输入电话号码"
        idnumInput.placeholder = "请输入身份证号"
        placeInput.placeholder = "请输入籍贯"
        comInput.placeholder = "请输入邮箱"
        
    }

}
