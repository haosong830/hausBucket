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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var timer = Timer()
    
    @IBOutlet weak var Map: MKMapView!
    var pinAnnotationView:MKPinAnnotationView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        Map.delegate=self
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GetData), userInfo: nil, repeats: true)

    
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            Map.delegate=self
            Map.mapType = MKMapType.standard
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
           // SetViewOnCurrentUser()
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
        
        //let region=MKCoordinateRegionMakeWithDistance(center,50,50)
        //Map.setRegion(region, animated: true)
        latitude=location.coordinate.latitude
        longitude=location.coordinate.longitude
       // GetData()
    }
    
    @objc func GetData(){
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
                    let URLString=backendip+"/images/"+tag.image
                    let imageURL=URL(string: URLString)!
                    let imageData = try Data(contentsOf: imageURL)
                    
                    
                    DataArray.append(DataInfo(longitude:tag.longitude, latitude:tag.latitude, altitude:0, text: tag.text, image: UIImage(data: imageData)!))
                    
                }
                DispatchQueue.main.async {
                for tags in DataArray{
                    let coordinate=CLLocationCoordinate2D(latitude: tags.latitude, longitude: tags.longitude)
                    let annotationtag=Annotation()
                    annotationtag.text=tags.text
                    annotationtag.image=tags.image
                    annotationtag.coordinate=coordinate
                    self.pinAnnotationView=MKPinAnnotationView(annotation: annotationtag, reuseIdentifier: "TagPin")
                    self.Map.addAnnotation(self.pinAnnotationView.annotation!)
                }
                }
                
                NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
                
            }catch let jsonErr{
                print (jsonErr)
            }
            }.resume()
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "TagPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
       
        
        if annotation is MKUserLocation{
            return nil
        }
      let customPointAnnotation = annotation as! Annotation
        
        annotationView?.image = resizeImage(image: customPointAnnotation.image, newWidth: 50)
        
        return annotationView
    }
    

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
