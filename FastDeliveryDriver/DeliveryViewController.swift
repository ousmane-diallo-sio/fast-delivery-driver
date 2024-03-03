//
//  DeliveryViewController.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import UIKit
import CoreLocation

class DeliveryViewController: UIViewController {

    @IBOutlet weak var lblDeliveryInfo: UILabel!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var iv: UIImageView!
    
    var delivery: Delivery!
    let locationManager = CLLocationManager()
    
    static func newInstance(delivery: Delivery) -> DeliveryViewController {
        let instance = DeliveryViewController()
        instance.delivery = delivery
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customerNameLabel = NSLocalizedString("customer_name_label", comment: "")
        let customerEmailLabel = NSLocalizedString("customer_email_label", comment: "")
        let customerPhoneNumberLabel = NSLocalizedString("customer_phone_number_label", comment: "")

        var deliveryInfo = ""
        deliveryInfo += "\(customerNameLabel) : \(delivery.customer.firstName) \(delivery.customer.lastName)\n"
        deliveryInfo += "\(customerEmailLabel) : \(delivery.customer.email)\n"
        deliveryInfo += "\(customerPhoneNumberLabel) : \(delivery.customer.phoneNumber)\n"

        lblDeliveryInfo.text = deliveryInfo
        
        if let _photo = delivery.photo?.photo {
            let imageData = Data(base64Encoded: _photo.data)!
            iv.image = UIImage(data: imageData)
        }
    }
    
    
    @IBAction func onBtnImageClick(_ sender: Any) {
        if let userLocation = locationManager.location {
            let address = delivery.customer.address
            let deliveryLocation = CLLocation(latitude: Double(address.x)!, longitude: Double(address.y)!)
            let distance = userLocation.distance(from: deliveryLocation)
            let distanceInMeters = distance.rounded()
            if distanceInMeters <= 200 {
                openLibrary()
            } else {
                let message = NSLocalizedString("too_far_from_delivery_location", comment: "")
                showToast(view: view, message: message)
            }
        } else {
            let message = NSLocalizedString("error_message", comment: "")
            showToast(view: self.view, message: message)
        }
    }
    
    // Works only on physical device
    @objc func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("No camera available")
            return
        }
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .camera
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        self.present(imgPicker, animated: true)
    }
    
    @objc func openLibrary() {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        self.present(imgPicker, animated: true)
    }
    
}

extension DeliveryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage,
              let imageData = image.jpegData(compressionQuality: 1)?.base64EncodedString() else {
            showToast(view: self.view, message: "error_message")
            return
        }
        self.iv.image = image
        delivery.photo = Photo(
            date: Date(),
            photo: PhotoData(data: imageData, contentType: "image/jpeg"),
            trackingId: "\(arc4random_uniform(UInt32.max))"
        )
        
        DeliveryWebService.updateDelivery(withID: delivery._id, photoData: imageData, completion: { error in
            if (error != nil) {
                DispatchQueue.main.async {
                    print("DeliveryWebService::updateDelivery : \(error)")
                }
            }
            DispatchQueue.main.async {
                picker.dismiss(animated: true)
                // self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}
