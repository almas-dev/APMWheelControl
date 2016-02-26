//
//  ViewController.swift
//  APMWheelControl
//
//  Created by Alexander Maslennikov on 02/24/2016.
//  Copyright (c) 2016 Alexander Maslennikov. All rights reserved.
//

import UIKit
import APMWheelControl

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orangeColor()

        let label = UILabel(frame: CGRectMake(25, 365, 95, 20))
        label.textAlignment = .Right
        label.text = "Current >>"
        view.addSubview(label)

        let wheelControl = APMWheelControl(frame: CGRectMake(150, 300, 150, 150))
        wheelControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wheelControl)
    }
    
}
