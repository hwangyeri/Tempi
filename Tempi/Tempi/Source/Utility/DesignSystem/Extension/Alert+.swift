//
//  Alert+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 43))
        toastLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        toastLabel.backgroundColor = UIColor.label.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.systemBackground
        toastLabel.font = .customFont(.pretendardRegularM)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 21
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.5, delay: 0.2, options: .curveLinear, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
