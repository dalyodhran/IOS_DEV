//
//  FocusSquare.swift
//  ARSurfaceDetection
//
//  Created by Odhrán Daly on 21/06/2018.
//  Copyright © 2018 Odhrán Daly. All rights reserved.
//

import Foundation
import ARKit

class FocusSquare: SCNNode {
    
    private let focusSquareSize: Float = 0.17
    private let focuseSquareThickness: Float = 0.018
    private let scaleForClosedSquare: Float = 0.97
    private let sideLengthForOpenSquareSegments: CGFloat = 0.2
    private let animationDuration = 0.7
    static let primaryColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
    static let primaryColorLight = #colorLiteral(red: 1, green: 0.9254901961, blue: 0.4117647059, alpha: 1)
    
    var lastPositionOnPlane: float3?
    var lastPostion: float3?
    private var isOpen = false
    private var isAnimating = false
    private var recentFocusSquarePostions: [float3] = []
    private var anchorsOfVisitedPlanes: Set<ARAnchor> = []
    
    override init() {
        super.init()
        self.opacity = 0.0
        //self.addChildNode(focusSquareNode)
        //open()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
    
    func update(for position: float3, planeAnchor: ARPlaneAnchor?, camera: ARCamera?) {
        
        recentFocusSquarePostions.append(position)
//        recentFocusSquarePostions.keepLast(8)
        
//        if let average = recentFocusSquarePostions.average{
//            self.simdPosition = average
//            self.setUniformScale(scaleBasedOnDistance(camera: camera))
//        }
        
        if let camera = camera {
            let tilt = abs(camera.eulerAngles.x)
            let threshold1: Float = .pi / 2 * 0.65
            let threshold2: Float = .pi / 2 * 0.75
            let yaw = atan2f(camera.transform.columns.0.x, camera.transform.columns.1.x)
            var angle: Float = 0
            
            switch tilt {
            case 0..<threshold1:
                angle = camera.eulerAngles.y
            case threshold1..<threshold2:
                let relativeInRange = abs((tilt - threshold1) / (threshold2 - threshold1))
                let normalizedY = normalize(camera.eulerAngles.y, forMinimalRotationTo: yaw)
                angle = normalizedY * (1 - relativeInRange) + yaw * relativeInRange
            default:
                angle = yaw
            }
            self.rotation = SCNVector4(0, 1, 0, angle)
        }
    }
    
    private func normalize(_ angle: Float, forMinimalRotationTo ref: Float) -> Float {
        
        var normalized = angle
        while abs(normalized - ref) > .pi / 4 {
            if angle > ref {
                normalized -= .pi / 2
            } else {
                normalized += .pi / 2
            }
        }
        return normalized
    }
    
    private func pulseAction() -> SCNAction {
        let pulseOutAction = SCNAction.fadeOpacity(by: 0.4, duration: 0.5)
        let pulseInAction = SCNAction.fadeOpacity(by: 1.0, duration: 0.5)
        pulseOutAction.timingMode = .easeInEaseOut
        pulseInAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([pulseOutAction, pulseInAction]))
    }
    
    private func stopPulsing(for node: SCNNode?) {
        node?.removeAction(forKey: "pulse")
        node?.opacity = 1.0
    }
    
    private func open(){
        if isOpen || isAnimating {
            return
        }
        
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        SCNTransaction.animationDuration = animationDuration / 4
//        focusSquareNode.opactity = 1.0
//        self.segment.forEach { segment in segment.open() }
//        SCNTransaction.completionBlock = { self.focusSquareNode.runAction(self.pulseAction(), forKey: "pulse") }
        SCNTransaction.commit()
        
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        SCNTransaction.animationDuration = animationDuration / 4
//        focusSquareNode.setUniformScale(focusSquareSize)
        SCNTransaction.commit()
        
        isOpen = true
    }
}
