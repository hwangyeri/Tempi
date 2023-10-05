//
//  TChecklistButton.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit

final class TImageButton: UIButton {
    
    init(imageSize: CGFloat, imageName: String, imageColor: UIColor) {
        super.init(frame: .zero)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)
        
        self.setImage(image, for: .normal)
        self.tintColor = imageColor
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


