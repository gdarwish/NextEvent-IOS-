//
//  SpinnerView.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-12.
//

import UIKit

private var aView: UIView?

extension UIViewController{
    
    func showSpinner(){
        // create a view
        aView = UIView(frame: self.view.bounds)
        // set the view background color
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        // create a UIActivityIndicatorView
        let ai = UIActivityIndicatorView(style: .large)
        // center the Indicator
        ai.center = aView!.center
        // start
        ai.startAnimating()
        // add the Indicator to the view
        aView?.addSubview(ai)
        // add the view
        self.view.addSubview(aView!)
    }
    
    func removeSpinner(){
        // removr the view
        aView?.removeFromSuperview()
        // set the view to nill to clean memory
        aView = nil
    }
    
}
