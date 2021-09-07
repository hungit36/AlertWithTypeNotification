//
//  HomeViewController.swift
//  AlertWithTypeNotification
//
//  Created by Hưng Nguyễn on 9/7/21.
//  Email: hungnguyen.it36@gmail.com
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.showAlertWithTypeNotification(title: "Demo", message: "Demo show alert with type notification", showCloseButton: false, isSuccess: true, timeShow: 5.0)
    }
    
    @IBAction func gotoChildView(_ sender: UIButton) {
        let vc = ChildViewController.instantiateFrom(storyboard: "Main", identifier: "ChildViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
