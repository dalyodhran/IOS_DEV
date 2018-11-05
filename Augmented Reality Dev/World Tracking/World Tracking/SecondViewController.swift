//
//  SecondViewController.swift
//  World Tracking
//
//  Created by Odhrán Daly on 14/02/2018.
//  Copyright © 2018 Odhrán Daly. All rights reserved.
//

import UIKit
import ARKit

class SecondViewController: UIView {
    
    var view: UIView!

    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }

}
