//
//  MapViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/18/21.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var previousLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000 //adjust the default zoom in here
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "segueToRegisterView" else {
            return
        }
        
        let registerVC = segue.destination as! RegisterViewController
        
        registerVC.addressFromMap = locationLabel.text
        
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
            let streetNumber = placemark.subThoroughfare ?? "St. No."
            let streetName = placemark.thoroughfare ?? "Salapan St."
            
            DispatchQueue.main.async {
                self.locationLabel.text = "\(String(describing: streetNumber)) \(streetName) \(city) \(country), \(postal)"
            }
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
       
        
    }
}
