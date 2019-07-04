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


class MainViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData(latitude: 35.047278, longitude: -85.3078294)
       
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //GetData(latitude: 0, longitude:0)
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        print("locations = \(locValue.latitude) \(locValue.longitude)")
        GetData(latitude: locValue.latitude, longitude: locValue.longitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    func GetData(latitude: Double, longitude: Double){
         var tags=[Tag]()
        DataArray.removeAll()
        let latitudeinstring=String(latitude)
        let longitudeinstring=String(longitude)
        //let jsonURLString="http://localhost/api/tags?latitude=35.047278&longitude=-85.3078294"
        

    let jsonURLString="http://localhost/api/tags?latitude="+latitudeinstring+"&longitude="+longitudeinstring
        
        guard let url=URL(string: jsonURLString) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            
            if let err=err{
                print ("Failed to get data from url:", err)
                return
            }
            guard let data=data else{
                return
            }
            do{
                let decoder=JSONDecoder()
                tags=try decoder.decode([Tag].self, from: data)
        
                
                for tag in tags{
                    DataArray.insert(DataInfo(longitude:tag.longitude, latitude:tag.latitude, altitude:0, text: tag.text, image: UIImage(named: "1.jpg")!), at: 0)
                    
                }
                NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
            }catch let jsonErr{
                print (jsonErr)
            }
            }.resume()

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
