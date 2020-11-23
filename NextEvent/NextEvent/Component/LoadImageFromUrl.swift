//
//  LoadImageFromUrl.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-22.
//

import UIKit


extension UIImageView{
    // create loadImage function that's used to load the image from url
    func loadImage(imgUrl: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imgUrl){
                if let image = UIImage(data: data){
                    DispatchQueue.main.sync {
                        self?.image = image
                    }
                }
            }
        }
    }
}
