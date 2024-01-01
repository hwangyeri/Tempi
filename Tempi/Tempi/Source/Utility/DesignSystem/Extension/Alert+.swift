//
//  Alert+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SwiftMessages

extension UIViewController {
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 210, height: 43))
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
    
    func showMessage(title: String, body: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.info)
        view.configureDropShadow()
        view.configureContent(title: title, body: body, iconText: "🎉")
        view.layoutMarginAdditions = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 50
        view.button?.isHidden = true
        
        if let iconLabel = view.iconLabel, let titleLabel = view.titleLabel, let bodyLabel = view.bodyLabel {
            iconLabel.font = UIFont.systemFont(ofSize: 25)
            titleLabel.font = UIFont.customFont(.pretendardSemiBoldM)
            bodyLabel.font = UIFont.customFont(.pretendardRegularXS)
        }
        
        SwiftMessages.show(view: view)
    }
    
    func showAlert(title: String, message: String, handler: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            handler?()
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
