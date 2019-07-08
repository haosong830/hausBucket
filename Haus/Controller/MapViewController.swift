//
//  MapViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 7/5/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let backendip: String="http://localhost"
    
    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            SetViewOnCurrentUser()
        }

 
        
        
        // Do any additional setup after loading the view.
    }
    func SetViewOnCurrentUser(){
        if let location=locationManager.location?.coordinate{
            let region=MKCoordinateRegionMakeWithDistance(location, 100, 100)
            Map.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location=locations.last else{
            return
        }
        
        let center=CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region=MKCoordinateRegionMakeWithDistance(center,50,50)
        Map.setRegion(region, animated: true)
        latitude=location.coordinate.latitude
        longitude=location.coordinate.longitude
        GetData()
    }
    
 func GetData(){
        var tags=[Tag]()
        
        let latitudeinstring=String(latitude)
        let longitudeinstring=String(longitude)
        print(latitudeinstring+" "+longitudeinstring)
        //let jsonURLString="http://localhost/api/tags?latitude=35.047278&longitude=-85.3078294"
        
        
        let jsonURLString=backendip+"/api/tags?latitude="+latitudeinstring+"&longitude="+longitudeinstring
        
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
                
                DataArray.removeAll(keepingCapacity: false)
                //self.Map.removeAnnotations(self.Map.annotations)
                for tag in tags{
                    let URLString=self.backendip+"/images/"+tag.image
                    let imageURL=URL(string: URLString)!
                    let imageData = try! Data(contentsOf: imageURL)
                    
                    DataArray.insert(DataInfo(longitude:tag.longitude, latitude:tag.latitude, altitude:0, text: tag.text, image: UIImage(data: imageData)!), at: 0)
                    
                }
                for tags in DataArray{
                    let coordinate=CLLocationCoordinate2D(latitude: tags.latitude, longitude: tags.longitude)
                    let annotation=Annotation(coordinate: coordinate, text: tags.text)
                    self.Map.addAnnotation(annotation)
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
