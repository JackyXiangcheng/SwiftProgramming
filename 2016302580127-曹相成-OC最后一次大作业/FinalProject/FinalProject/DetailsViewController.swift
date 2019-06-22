//
//  DetailsViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/3.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    var sname: String?
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var sno: UILabel!
    
    @IBOutlet weak var dep: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var IDnum: UILabel!
    
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var com: UILabel!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "change"{
            let controller = segue.destination as! PickInfoViewController
            controller.sname = sender as? String
        }
    }

    @IBAction func pressBack(_ sender:UIButton){
        performSegue(withIdentifier: "deleted", sender: "")
    }
    @IBAction func pressChange(_ sender:UIButton){
            self.performSegue(withIdentifier: "change", sender: sname)
    }
    @IBAction func pressDelete(_ sender:UIButton){
       
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stu")
        do{
            let stuList = try managedObjectContext.fetch(fetchRequest)as! [Stu]
            for s:Stu in stuList{
                let myName = s.name!
                if myName == sname{
                    s.managedObjectContext?.delete(s)
                    do{
                        try s.managedObjectContext?.save()
                        
                    }catch
                    {
                        print("failed")
                    }
                }
            }
        }catch{
        }
        performSegue(withIdentifier: "deleted", sender: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let stuName:String = sname!
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stu")
        do{
            let stuName:String! = sname
            let stuList = try managedObjectContext.fetch(fetchRequest)as! [Stu]
            for s in stuList{
                if s.name == stuName{
                    name.text = s.name
                    sno.text = s.dep        //原本数据顺序出错，为了方便就没有再更改了
                    dep.text = s.sno
                    phone.text = s.phone
                    IDnum.text = s.iDnum
                    place.text = s.place
                    com.text = s.com
                }
            }
           
        }catch{
            print("错误")
        }
    }
}
