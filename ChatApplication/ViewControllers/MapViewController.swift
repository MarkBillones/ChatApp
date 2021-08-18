//
//  MapViewController.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/18/21.
//

import MapKit
import UIKit

class MapViewController: UIViewController {

    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    

}
