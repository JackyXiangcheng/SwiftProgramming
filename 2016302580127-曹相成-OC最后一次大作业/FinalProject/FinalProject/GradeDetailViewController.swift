//
//  GradeDetailViewController.swift
//  FinalProject
//
//  Created by 曹相成 on 2019/6/2.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit

class GradeDetailViewController: UIViewController {
    var grade: Grade?
    @IBOutlet weak var grade1:UITextField!
    
    @IBOutlet weak var grade2: UITextField!
    
    @IBOutlet weak var grade3: UITextField!
    
    @IBOutlet weak var grade4: UITextField!
    
    @IBAction func pressBack(_ sender:UIButton){
        performSegue(withIdentifier: "backToGradeQ", sender: "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.grade1.text = "\(grade?.politics ?? 0)"
        self.grade2.text = "\(grade?.chinese ?? 0)"
        self.grade3.text = "\(grade?.math ?? 0)"
        self.grade4.text = "\(grade?.english ?? 0)"
        
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
