//
//  CameraViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 7/9/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit
import ARKit
import SpriteKit

class CameraViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var ARViewer: ARSCNView!
    @IBAction func unwind(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ARViewer.delegate=self
        let scene=SCNScene()
        ARViewer.scene=scene
        ARViewer.debugOptions=[ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        ARViewer.showsStatistics=true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ARViewer.session.run(ARWorldTrackingConfiguration())
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        ARViewer.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch=touches.first else{
            return
        }
        let result=ARViewer.hitTest(touch.location(in: ARViewer), types: ARHitTestResult.ResultType.featurePoint)
        guard let hitresult=result.last else {
            return
        }
        let hittransform=SCNMatrix4.init(hitresult.worldTransform)
        let hitvector=SCNVector3Make(hittransform.m41, hittransform.m42, hittransform.m43)
        CreateObject(position: hitvector)
        
    }
    
    func CreateObject(position: SCNVector3){
        let ball=SCNSphere(radius: 0.5)
        let ballnode=SCNNode(geometry: ball)
        guard let scene=SCNScene(named: "3dobjects.scnassets/untitled.scn") else{
            return
        }
        
        
        ballnode.position=position
        ARViewer.scene.rootNode.addChildNode(ballnode)
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
