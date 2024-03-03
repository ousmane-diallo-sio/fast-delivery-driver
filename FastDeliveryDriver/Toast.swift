//
//  Toast.swift
//  AlbumApp
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation
import UIKit

func showToast(view: UIView, message: String) {
    let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 125, y: view.frame.size.height-100, width: 250, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center
    toastLabel.font = UIFont.systemFont(ofSize: 12)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    view.addSubview(toastLabel)
    
    UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
