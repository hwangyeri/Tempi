//
//  Alert+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit

extension UIViewController {
    
    /// 카테고리, 즐겨찾기 삭제 시 쓰이는 Alert
    func presentDeleteAlert(title: String, message: String, deleteHandler: @escaping () -> Void) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            
            deleteHandler()
            
            NotificationCenter.default.post(name: NSNotification.Name("DataDidChange"), object: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

