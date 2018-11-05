//
//  ViewController.swift
//  Planets
//
//  Created by Odhrán Daly on 09/02/2018.
//  Copyright © 2018 Odhrán Daly. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.3))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sun")
        sun.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "earth"), specular: #imageLiteral(resourceName: "earth specular"), emission: #imageLiteral(resourceName: "earth cloud"), normal: #imageLiteral(resourceName: "earth normal"), position: SCNVector3(1.2,0,0))
        sun.addChildNode(earth)
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "venus surface"), specular: nil, emission: #imageLiteral(resourceName: "venus Atmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        sun.addChildNode(earth)
        sun.addChildNode(venus)
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
//        let forever = SCNAction.repeatForever(action)
//        earth.runAction(forever)
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
        let planet = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

