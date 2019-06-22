//
//  PickInfoViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/3.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData

class PickInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var sname:String?
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var input: UITextField!
    
    @IBAction func pressOut(_ sender: UIButton) {
        performSegue(withIdentifier: "completeChange", sender: "")
    }
    
    
    @IBAction func pressSubmit(_ sender:UIButton){
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let stuName:String = sname!
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stu")
        let prop = self.pickView.selectedRow(inComponent: 0)
        do{
            let stuName:String! = sname
            let stuList = try managedObjectContext.fetch(fetchRequest)as! [Stu]
            for s in stuList{
                if s.name == stuName{
                    switch prop{
                    case 0:do {
                        s.dep = input.text
                        break
                        }
                    case 1:do{
                        s.sno = input.text
                        break
                        }
                    case 2:do{
                        s.phone = input.text
                        break
                        }
                    case 3:do{
                        s.iDnum = input.text
                        }
                    case 4:do{
                        s.place = input.text
                        }
                    case 5:do{
                        s.com = input.text
                        }
                    default:
                        print("error")
                    }
                    do{
                        try managedObjectContext.save()
                    }catch{
                        print("失败")
                    }
                    performSegue(withIdentifier: "completeChange", sender: sname)
                }
            }
        }catch{
            print("错误")
        }
    }
    //返回数量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //可选的数量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if row == 0{
            return "学号"
        }else if row == 1{
            return "学院"
        }else if row == 2{
            return "电话"
        }else if row == 3{
            return "身份证号码"
        }else if row == 4{
            return "籍贯"
        }else if row == 5{
            return "邮箱"
        }
        return "error"
    }

    @IBOutlet weak var pickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        
        pickerView.delegate = self
        //设置选择框的默认值
        pickerView.selectRow(1,inComponent:0,animated:true)
        pickerView.selectRow(2,inComponent:0,animated:true)
        pickerView.selectRow(3,inComponent:0,animated:true)
        pickerView.selectRow(4,inComponent:0,animated:true)
        pickerView.selectRow(5,inComponent:0,animated:true)
        
        self.view.addSubview(pickerView)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completeChange"{
            let controller = segue.destination as! DetailsViewController
            controller.sname = sender as? String
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
