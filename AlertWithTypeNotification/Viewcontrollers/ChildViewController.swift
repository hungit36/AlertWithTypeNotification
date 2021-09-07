//
//  ChildViewController.swift
//  AlertWithTypeNotification
//
//  Created by Hưng Nguyễn on 9/7/21.
//  Email: hungnguyen.it36@gmail.com
//

import UIKit

class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.showAlertWithTypeNotification(title: "Demo", message: "Demo show alert with type notification in child View", showCloseButton: true, isSuccess: true, timeShow: 5.0)
    }

}
