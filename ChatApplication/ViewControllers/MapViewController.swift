//
//  MapViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/18/21.
//

import CoreLocation
import MapKit
import UIKit

protocol ModalViewControllerDelegate {
    
    func sendValue(stringValue: String)
    
}

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var delegate: ModalViewControllerDelegate!
    
    var previousLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000 //adjust the default zoom in here, with meters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(confirmButton)
    }
    
    func setUpLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }

    func render (_ location: CLLocation) {

        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude  , longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        
        mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
        
        //translating GeocodeLocation to Address
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(getCenterLocation(for: mapView)) { [weak self] (placemarks, error) in
            guard let self = self else { return }

            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                print(#function)
                return
            }
            
            let postal = placemark.postalCode ?? "Postal"
            let country = placemark.country ?? "Country"
            let city = placemark.locality ?? "City"
            let streetName = placemark.thoroughfare ?? "eg. Salapan St."
            let placeName = placemark.name ?? "eg. Apple"
            
            DispatchQueue.main.async {
                self.locationLabel.text = "\(placeName), \(streetName) \(city) \(country), \(postal)"
            }
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
    @IBAction func currentLocationTapped() {
        
        
        self.delegate?.sendValue(stringValue: "I sent a value, finally!")
        dismiss(animated: true, completion: nil)
        
    }
    
}
