//
//  ViewController.swift
//  Hello AR
//
//  Created by Odhrán Daly on 23/10/2017.
//  Copyright © 2017 Odhrán Daly. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

enum BodyType: Int {
    case box = 1
    case plane = 2
    case car = 3
}

class ViewController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet var sceneView: ARSCNView!
    var planes = [OverlayPlane]()
    
//    var boxes = [SCNNode]()
    
    
    private let lable :UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Setting plain detection text
//        self.lable.frame = CGRect(x: 0, y: 0, width: self.sceneView.frame.size.width, height: 44)
//        self.lable.center = self.sceneView.center
//        self.lable.textAlignment = .center
//        self.lable.textColor = UIColor.white
//        self.lable.font = UIFont.preferredFont(forTextStyle: .headline)
//        self.lable.alpha = 0
//
//        self.sceneView.addSubview(self.lable)
        
        
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
//        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
//        This is creating a cub and adding it
        
//        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.1)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.red
//
//        let node = SCNNode()
//
//        node.geometry = box
//        node.geometry?.materials = [material]
//        node.position = SCNVector3(0, 0.1, -0.5)
//
//        scene.rootNode.addChildNode(node)
        
//        This is creating text and adding it
//        let textGeometry = SCNText(string: "Hello World", extrusionDepth: 1.0)
//        textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
//
//        let textNode = SCNNode(geometry: textGeometry)
//        textNode.position = SCNVector3(0, 0.1, -0.5)
//        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        
//        scene.rootNode.addChildNode(textNode)
//
//        Adding two objects with images on the objects
    
//        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "brick-wall.jpg")
//
//        let node = SCNNode()
//        node.geometry = box
//        node.geometry?.materials = [material]
//        node.position = SCNVector3(-0.1, 0.1, -0.5)
//
//        let sphere = SCNSphere(radius: 0.2)
//
//        let sphereMaterial = SCNMaterial()
//        sphereMaterial.diffuse.contents = UIImage(named: "earth.jpeg")
//
//        let sphereNode = SCNNode()
//        sphereNode.geometry = sphere
//        sphereNode.geometry?.materials = [sphereMaterial]
//        sphereNode.position = SCNVector3(0.5, 0.1, -1)
//        
//        scene.rootNode.addChildNode(sphereNode)
//        scene.rootNode.addChildNode(node)
        
//        This is the tap guesture working with the @objc func tapped method
//        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
//
//        let material = SCNMaterial()
//        material.name = "Color"
//        material.diffuse.contents = UIColor.red
//
//        let node = SCNNode()
//        node.geometry = box
//        node.geometry?.materials = [material]
//        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
//
//        scene.rootNode.addChildNode(node)
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        // Set the scene to the view
        sceneView.scene = scene
        
        registerGestureRecognizer()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let estimate = self.sceneView.session.currentFrame?.lightEstimate
        if(estimate == nil) {
            return
        }
        
        let intensity = (estimate?.ambientIntensity)! / 1000.0
        self.sceneView.scene.lightingEnvironment.intensity = intensity
    }
    
//    Tapped function
//    @objc func tapped(recognizer: UIGestureRecognizer){
//
//        let sceneView = recognizer.view as! SCNView
//        let touchLocation = recognizer.location(in: sceneView)
//        let hitResult = sceneView.hitTest(touchLocation, options: [:])
//
//        if !hitResult.isEmpty {
//
//            let node = hitResult[0].node
//            let material = node.geometry?.material(named: "Color")
//
//            material?.diffuse.contents = UIColor.random()
//
//        }
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
//    Plane detection method
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//
//        DispatchQueue.main.async {
//            self.lable.text = "Plane Detected"
//
//            UIView.animate(withDuration: 3.0, animations: {
//
//                self.lable.alpha = 1.0
//
//            }) { (completion :Bool) in
//
//                self.lable.alpha = 0.0
//            }
//        }
//
//
//
//    }
    
//    Overlaying and appending a plane to a surface
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if !(anchor is ARPlaneAnchor){
            return
        }

        let plane = OverlayPlane(anchor: anchor as! ARPlaneAnchor)
        self.planes.append(plane)
        node.addChildNode(plane)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
        }.first

        if plane == nil {
            return
        }

        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
    
    private func registerGestureRecognizer() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        let doubleTappedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTappedGestureRecognizer.numberOfTapsRequired = 2
        
        tapGestureRecognizer.require(toFail: doubleTappedGestureRecognizer)
        
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(doubleTappedGestureRecognizer)
        
    }
    
    @objc func doubleTapped(recognizer :UIGestureRecognizer){
        
//        let sceneView = recognizer.view as! ARSCNView
//        let touch = recognizer.location(in: sceneView)
//
//        let hitResults = sceneView.hitTest(touch, options:[:])
//
//        if !hitResults.isEmpty {
//            guard let hitResult = hitResults.first else {
//                return
//            }
//
//            let node = hitResult.node
//
//            node.physicsBody?.applyForce(SCNVector3(hitResult.worldCoordinates.x * Float(2.0), 2.0, hitResult.worldCoordinates.z * Float(2.0)), asImpulse: true)
//        }
        
        print("doubleTapped")
        self.sceneView.debugOptions = []
        
        let configuration = self.sceneView.session.configuration as! ARWorldTrackingConfiguration
        
        configuration.planeDetection = []
        self.sceneView.session.run(configuration, options: [])
        
        // turn off the grid
        for plane in self.planes {
            plane.planeGeometry.materials.forEach { material in
                material.diffuse.contents = UIColor.clear
            }
        }
        
    }
    
    @objc func tapped(recognizer :UIGestureRecognizer){
        
        let sceneView = recognizer.view as! ARSCNView
        let touchLocation = recognizer.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if !hitTestResult.isEmpty {
            guard let hitResult = hitTestResult.first else {
                return
            }
            addTable(hitResult : hitResult)
        }
        
        
    }
    
    private func addTable(hitResult :ARHitTestResult){
        
        let tableScene = SCNScene(named: "bench.dae")!
        let tableNode = tableScene.rootNode.childNode(withName: "SketchUp", recursively: true)
        
        tableNode?.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        tableNode?.scale = SCNVector3(0.5, 0.5, 0.5)
        
        self.sceneView.scene.rootNode.addChildNode(tableNode!)
    }
    
//    private func addBox(hitResult: ARHitTestResult){
//
//        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.1, chamferRadius: 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.green
//
//        boxGeometry.materials = [material]
//
//        let boxNode = SCNNode(geometry: boxGeometry)
//        boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//        boxNode.physicsBody?.categoryBitMask = BodyType.box.rawValue
//
//        self.boxes.append(boxNode)
//
//        boxNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + Float(0.5), hitResult.worldTransform.columns.3.z)
//
//        self.sceneView.scene.rootNode.addChildNode(boxNode)
//    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
