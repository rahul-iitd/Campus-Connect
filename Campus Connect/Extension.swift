//
//  Extension.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 26/05/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView{
    func loadImage(_ urlString: String?, onSucess: ((UIImage)->Void)? = nil){
        self.image = UIImage()
        guard let string = urlString else {return}
        guard let url = URL(string: string) else {return}
        
        self.sd_setImage(with: url) { (image, error, type, url) in
            if onSucess != nil, error==nil{
                onSucess!(image!)
            }
        }
        
    }
}
