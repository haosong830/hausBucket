//
//  MainViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 6/30/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit
import CoreLocation




var DataArray=[DataInfo]()
var latitude: Double=0
var longitude: Double=0
var altitude: Double=0


class MainViewController: UIViewController {
  
    let backendip: String="http://localhost"
    override func viewDidLoad() {
        super.viewDidLoad()
        DataArray.removeAll(keepingCapacity: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
