//
//  Alert+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit

extension UIViewController {
    
    /// 카테고리, 즐겨찾기 삭제 시 쓰이는 Alert
//    func presentDeleteAlert(title: String, message: String, deleteHandler: @escaping () -> Void) {
//        let alertController = UIAlertController(
//            title: title,
//            message: message,
//            preferredStyle: .alert
//        )
//        
//        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
//            
//            deleteHandler()
//            
//            NotificationCenter.default.post(name: NSNotification.Name("DataDidChange"), object: nil)
//        }
//        
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        
//        alertController.addAction(deleteAction)
//        alertController.addAction(cancelAction)
//        
//        present(alertController, animated: true, completion: nil)
//    }
    
    func showToast(message : String) {
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height - 450, width: 200, height: 40))
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 43))
        toastLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        toastLabel.backgroundColor = UIColor.tGray1000.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.tGray100
        toastLabel.font = .customFont(.pretendardRegularM)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 21
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

//presentDeleteAlert(title: "ddd", message: "ddd") {
//    print(#function)
//}
