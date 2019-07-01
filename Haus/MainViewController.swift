//
//  MainViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 6/30/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit

//var ImageArray=[UIImage (named: "1.jpg")]

struct DataInfo{
    var longitude: Int
    var latitude: Int
    var altitude: Int
    var text: String
    var image: UIImage
}

var DataArray=[DataInfo(longitude:0, latitude:0, altitude:0, text:"What is This", image: UIImage(named: "1.jpg")!), DataInfo(longitude:0, latitude:0, altitude:0, text:"All your Bases Are Belong to US", image: UIImage(named: "1.jpg")!)]
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddImages(_ sender: Any) {
        DataArray.insert(DataInfo(longitude:0, latitude:0, altitude:0, text:"All your Bases Are Belong to US", image: UIImage(named: "1.jpg")!), at: 0)
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
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
