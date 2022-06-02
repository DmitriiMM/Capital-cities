//
//  ViewController.swift
//  Project16
//
//  Created by Дмитрий Мартынов on 01.12.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capitals(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capitals(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capitals(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capitals(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capitals(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Вид", style: .done, target: self, action: #selector(choose))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func choose() {

        let ac = UIAlertController(title: "Choose type of map", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "satellite", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satellite
        })
        ac.addAction(UIAlertAction(title: "hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybrid
        })
        ac.addAction(UIAlertAction(title: "hybridFlyover", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybridFlyover
        })
        ac.addAction(UIAlertAction(title: "mutedStandard", style: .default) { [weak self] _ in
            self?.mapView.mapType = .mutedStandard
        })
        ac.addAction(UIAlertAction(title: "standard", style: .destructive) { [weak self] _ in
            self?.mapView.mapType = .standard
        })
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capitals else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capitals else { return }
        
        let wvc = WikiViewController()
        wvc.placeName = capital.title
        
        navigationController?.pushViewController(wvc, animated: true)
    }
}

