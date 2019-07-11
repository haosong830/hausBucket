//
//  CameraViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 7/9/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit
import ARKit

class CameraViewController: UIViewController {

    @IBOutlet weak var ARViewer: ARSCNView!
    @IBAction func unwind(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ARViewer.session.run(ARWorldTrackingConfiguration())

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="uploadimage"{
            if let viewController2 = segue.destination as? UploadImageViewController {
                viewController2.image=ARViewer.snapshot()
                
        }
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
