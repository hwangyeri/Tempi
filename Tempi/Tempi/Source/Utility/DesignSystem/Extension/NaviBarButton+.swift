//
//  NaviBarButton+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/30.
//

import UIKit

extension UIViewController {
    
    // MARK: - RightBarButton 설정
    func setRightBarButton() {
        let rightBarButtonIcon = UIImage(systemName: Constant.SFSymbol.xmarkIcon)
        let rightBarButton = UIBarButtonItem(image: rightBarButtonIcon, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        DispatchQueue.main.async {
            rightBarButton.tintColor = .label
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    // MARK: - 나가기 버튼 (Navi BarButton)
    @objc private func rightBarButtonTapped() {
        print(#function)
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - BackBarButton 설정
    func hideBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

