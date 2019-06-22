//
//  LoginViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/5.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    var registerIn: [NSManagedObject] = []
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(0, forKey: "status")
    }
    
    @IBAction func login(_ sender: Any) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "RegisterInfo", in: context)
        let request = NSFetchRequest<NSManagedObject>(entityName: "RegisterInfo")
        let predicate = NSPredicate(format:"name=%@ && pwd=%@",name.text ?? "",password.text ?? "")
        request.predicate = predicate
        request.entity = entity
        do{
            //let results:[AnyObject]? = try context.fetch(request)
            print(try context.fetch(request))
            registerIn = try context.fetch(request)
            
            
            if(registerIn.count == 0){
                let alertController = UIAlertController(title: "登录失败", message: "登录失败请重试！", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "好的", style: .destructive, handler: nil)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "登录成功", message: "登录成功！", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "好的", style: .destructive, handler: nil)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                //dispUsername.text = username.text
                //name.text = nil
                //password.text = nil
                //detailView.isHidden = false;
                UserDefaults.standard.set(1, forKey: "status")  //Integer
            }
        } catch{
            print("显示数据失败")
        }
    }
    
    @IBAction func register(_ sender: Any) {
        //插入数据
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let registerinfo = NSEntityDescription.insertNewObject(forEntityName: "RegisterInfo", into: context) as! RegisterInfo
        registerinfo.name = name.text
        registerinfo.pwd = password.text
        
        do{
            try context.save()
            
            let alertController = UIAlertController(title: "注册成功", message: "注册成功", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            print("插入数据成功")
        } catch{
            print("插入数据失败")
        }
    }
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(0, forKey: "status")
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
