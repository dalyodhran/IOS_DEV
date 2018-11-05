//
//  ViewController.swift
//  World Tracking
//
//  Created by Odhrán Daly on 08/02/2018.
//  Copyright © 2018 Odhrán Daly. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func moveButton(_ sender: Any) {
        self.navigationController!.pushViewController(SecondViewController(nibName: "SecondViewController", bundle: nil), animated: true );
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2,0.3,-0.2)
        node.eulerAngles = SCNVector3(Float(180.degreesToRadians), 0, 0)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        
        
    }
    
    func resetSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
//    node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
    //        let path = UIBezierPath()
    //        path.move(to: CGPoint(x: 0, y:0))
    //        path.addLine(to: CGPoint(x: 0, y: 0.2))
    //        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
    //        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
    //        path.addLine(to: CGPoint(x: 0.4, y: 0))
    //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
    //        node.geometry = shape
//    let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.15))
//    cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//    cylinder.position = SCNVector3(0, 0, -0.3)
//    cylinder.eulerAngles = SCNVector3(0, 0, Float(90.degreesToRadians))
//    self.sceneView.scene.rootNode.addChildNode(cylinder)
//
//    let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.2))
//    pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//    pyramid.position = SCNVector3(0, 0, -0.5)
//    cylinder.addChildNode(pyramid)
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}
