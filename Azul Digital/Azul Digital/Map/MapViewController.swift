//
//  MapViewController.swift
//  Azul Digital
//
//  Created by Leonardo Tsuda on 7/11/16.
//  Copyright © 2016 Leonardo Tsuda. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func logout(_ sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "UINavigationControllerMain")
        present(initialViewController, animated: true, completion: nil)
        //        UIApplication.shared().delegate?.window??.rootViewController = initialViewController
    }
    
    @IBAction func requestLocation(_ sender: AnyObject) {
        requestUserLocation()
    }
    @IBAction func buyTicket(_ sender: AnyObject) {
        
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        requestUserLocation()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func requestUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro: \(error.localizedDescription)")
    }
    
}
