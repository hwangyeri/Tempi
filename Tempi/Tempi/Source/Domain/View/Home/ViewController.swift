//
//  ViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames {
            print(family)
            
            for names in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
    }


}

/*
 Pretendard
 == Pretendard-Regular
 == Pretendard-Medium
 == Pretendard-SemiBold
 == Pretendard-Bold
 == Pretendard-Black
 */

