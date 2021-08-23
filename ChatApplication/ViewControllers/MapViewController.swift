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
    
    var delegate: mapDataVCDelegate? = nil
    
    var countryTextHolder  = ""
    var zipCodeTextHolder  = ""
    var cityTextHolder     = ""
    var provinceTextHolder = ""
    
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
            let streetName = placemark.thoroughfare ?? "No current St."
            let province = placemark.subAdministrativeArea ?? "Province"
            let placeName = placemark.name ?? "" //stablishment Name
            
            DispatchQueue.main.async {
                self.locationLabel.text = "\(placeName), \(streetName) \(city), \(province), \(country), \(postal)"
                
                self.countryTextHolder  = country
                self.zipCodeTextHolder  = postal
                self.cityTextHolder     = city
                self.provinceTextHolder = province
            }
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
    @IBAction func currentLocationTapped() {
        
        if self.delegate != nil {
            
            let countryTextResult = countryTextHolder
            let zipCodeTextResult = zipCodeTextHolder
            let cityTextResult = cityTextHolder
            let provinceTextResult = provinceTextHolder
            
            self.delegate?.sendValue(countryText: countryTextResult,
                                     zipCodeText: zipCodeTextResult,
                                     cityText: cityTextResult,
                                     provinceText: provinceTextResult)
            
            navigationController?.popViewController(animated: true) //popVC is like clicking the back button
        }
    }
}

