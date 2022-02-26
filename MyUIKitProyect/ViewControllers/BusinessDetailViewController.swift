//
//  BusinessDetailViewController.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 7/1/22.
//

import UIKit
import CoreLocation
import MapKit

class BusinessDetailViewController: UIViewController {
    
    
    //MARK: - Properties
    var business: BusinessModel? = nil
    
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = business?.name
        self.addressLabel.text = business?.address
        self.descriptionLabel.text = business?.description
        
        if let lat = business?.latitude, let long = business?.longitude {
            self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), latitudinalMeters: CLLocationDistance(500), longitudinalMeters: CLLocationDistance(500)), animated: false)
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            mapView.addAnnotation(pin)
        }
        
    }
    
    
}
