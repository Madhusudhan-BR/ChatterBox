//
//  MapViewController.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/19/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var region = MKCoordinateRegion()
        
        region.center.latitude = location.coordinate.latitude
        region.center.longitude = location.coordinate.longitude
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        mapView.addAnnotation(annotation)
        annotation.coordinate = location.coordinate
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    
    
    
}
