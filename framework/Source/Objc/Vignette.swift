import Foundation
import CoreGraphics
import UIKit

public class Vignette: BasicOperation {
    public var center:Position = Position.center { didSet { uniformSettings["vignetteCenter"] = center } }
    public var color:Color = Color.black { didSet { uniformSettings["vignetteColor"] = color } }
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5){ didSet { center = Position(point: ocCenter) } }
    @objc open var ocColor:UIColor = UIColor.black { didSet { color = ocColor.aplColorToGpuColor() } }
    @objc open var start:Float = 0.3 { didSet { uniformSettings["vignetteStart"] = start } }
    @objc open var end:Float = 0.75 { didSet { uniformSettings["vignetteEnd"] = end } }
    
    public init() {
        super.init(fragmentShader:VignetteFragmentShader, numberOfInputs:1)
        
        ({center = Position.center})()
        ({color = Color.black})()
        ({start = 0.3})()
        ({end = 0.75})()
    }
}
