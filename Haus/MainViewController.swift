//
//  MainViewController.swift
//  Haus
//
//  Created by Qingyang Liu on 6/30/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import UIKit
import MapKit

//var ImageArray=[UIImage (named: "1.jpg")]

struct DataInfo{
    var longitude: Int
    var latitude: Int
    var altitude: Int
    var text: String
    var image: UIImage
}

var DataArray=[DataInfo(longitude:0, latitude:0, altitude:0, text:"What is This", image: UIImage(named: "1.jpg")!), DataInfo(longitude:0, latitude:0, altitude:0, text:"All your Bases Are Belong to US", image: UIImage(named: "1.jpg")!)]

var pins: [Pin] = [] // This will hold all of the pins

class MainViewController: UIViewController, CLLocationManagerDelegate {
    // Mark: Outlets
    // used to control what the map displays
    @IBOutlet weak var mapView: MKMapView!

    // set up the location manager
    let locManager = CLLocationManager();
    func setupLocationManager() {
        locManager.delegate = self;
        locManager.desiredAccuracy = kCLLocationAccuracyBest;
        locManager.requestWhenInUseAuthorization();
        locManager.startUpdatingLocation();
    }
    // shows the user's location? that blue bubble thing
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0];
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1);
        let myLoc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLoc, span);
        mapView.setRegion(region, animated: true);
        self.mapView.showsUserLocation = true;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

         setupLocationManager();
        // note: right now it's not using different emojis for different disciplines
        Pin.addBeginningAnnotations(mapView: self.mapView);
        
        // TODO: figure out what this does. I think it saves time loading images but I'm not sure
        mapView.register(PinView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    //
    /* func checkLocation() {
     if (CLLocationManager.locationServicesEnabled()) {
     setupLocationManager();
     checkLocationAuth();
     }
     else {
     
     }
     }*/
    
    
    
    /*func checkLocationAuth() {
     switch CLLocationManager.authorizationStatus() {
     case .authorizedWhenInUse:
     mapview.showsUserLocation = true;
     break;
     case .denied:
     break;
     case .notDetermined:
     locManager.requestWhenInUseAuthorization();
     break;
     case .restricted:
     break;
     case .authorizedAlways:
     break;
     default:
     break;
     }
     }*/
    
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
    
    let regionRadius: CLLocationDistance = 500 // (meters) Note: later we can change this and make it dynamic
    /// centers the map on the passed in location with a radius of
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // this is the function that we should call in an overriden built in function like "applicationDidEnterBackground" to load the data from the backend somehow
    func loadInitialData() {
        // TODO: load the data from the backend
        // Note: to start we can just put a json file to read pins from
    }
    
    
}

// TODO: comment this and figure it out so pins aren't just boring red things
extension MainViewController: MKMapViewDelegate {
 /*
    // this is called for every pin you add to the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // if it's not a pin, use the default view
        guard let annotation = annotation as? Pin else { return nil }
        // makes the red pin appear TODO: fix so it's not just a red marker
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // try to reuse one first
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // if you can't reuse one, make a new one
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
 */
}
