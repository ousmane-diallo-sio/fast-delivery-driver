//
//  HomeViewController.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 07/02/2024.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {

    var driver: Driver!
    var rounds: [Round] = []
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    static func newInstance(driver: Driver) -> HomeViewController {
        let instance = HomeViewController()
        instance.driver = driver
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(onLogoutRequest))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(getDelieryRound))
        navigationItem.title = "\(driver.firstName) \(driver.lastName)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestLocationPermission()
        getDelieryRound()
    }
    
    @objc func onLogoutRequest() {
        navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
    
    @objc func getDelieryRound() {
        RoundWebService.getAllRounds(completion: { rounds, err in
            if (err != nil) {
                print("Home::getDeliveryRound error : \(err)")
                DispatchQueue.main.async {
                    showToast(view: self.view, message: NSLocalizedString("error_message", comment: ""))
                }
                return
            }
            
            DispatchQueue.main.async {
                self.rounds = rounds
                self.presentAvailableRounds()
                if (rounds.isEmpty) {
                    showToast(view: self.view, message: NSLocalizedString("err_no_rounds", comment: ""))
                }
                
            }
        })
    }
    
    func presentAvailableRounds() {
        let title = NSLocalizedString("select_round_label", comment: "")
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let deliveriesLabel = NSLocalizedString("deliveries", comment: "")
        
        for round in rounds {
            let formattedDate = dateFormatter.string(from: round.date)
            let action = UIAlertAction(title: "\(formattedDate) (\(round.deliveries.count) \(deliveriesLabel))", style: .default) { _ in
                self.onRoundSelected(round: round)
            }
            alertController.addAction(action)
        }
        
        let cancelLabel = NSLocalizedString("cancel", comment: "")
        
        let cancelAction = UIAlertAction(title: cancelLabel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func onRoundSelected(round: Round) {
        print("onRoundSelected \(round)")
        
        let deliveryAnnotations = round.deliveries.map{ delivery in
            return DeliveryAnnotation(delivery: delivery)
        }
        
        map.addAnnotations(deliveryAnnotations)
        map.showAnnotations(map.annotations, animated: true)
        
    }
    
    func requestLocationPermission() {
        if (self.locationManager == nil) {
            let manager = CLLocationManager()
            
            manager.delegate = self
            if (CLLocationManager.authorizationStatus() == .notDetermined) {
                manager.requestWhenInUseAuthorization()
            }
            self.locationManager = manager
        }
        
        self.handleLocationManagerStatus(self.locationManager!)
    }

}

extension HomeViewController : CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocation : \(locations)")
        if let location = locations.first {
            currentLocation = location
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization : \(CLLocationManager.authorizationStatus().rawValue)")
        self.handleLocationManagerStatus(manager)
    }
    
    func handleLocationManagerStatus(_ locationManager: CLLocationManager) {
        let status = CLLocationManager.authorizationStatus()
        
        if (status == .restricted || status == .denied) {
            self.handleLocationDenied()
        } else if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
        }
    }
    
    func handleLocationDenied() {
        let alert = UIAlertController(
            title: "FBI really wants to know your location.",
            message: "",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ouvrir les paramètres", style: .destructive, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        
        self.present(alert, animated: true)
    }
}

extension HomeViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let deliveryAnnotation = annotation as? DeliveryAnnotation else {
            print("mapView:: as? DeliveryAnnotation failed")
            return
        }
        print("mapView:: didSelect")
        
        let deliveryViewController = DeliveryViewController.newInstance(delivery: deliveryAnnotation.delivery);
        self.navigationController?.pushViewController(deliveryViewController, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            print("mapView:: is MKUserLocation failed")
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "driver-id")
        if view == nil {
            let newView = MKAnnotationView(annotation: annotation, reuseIdentifier: "driver-id")
            newView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            view = newView
        } else {
            view!.annotation = annotation
        }
        
        view!.image = UIImage(named: "driver")
        view!.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        return view
    }
}
