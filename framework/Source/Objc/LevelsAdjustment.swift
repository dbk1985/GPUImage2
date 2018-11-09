import Foundation
import UIKit

public class LevelsAdjustment: BasicOperation {
    public var minimum:Color = Color(red:0.0, green:0.0, blue:0.0) { didSet { uniformSettings["levelMinimum"] = minimum } }
    public var middle:Color = Color(red:1.0, green:1.0, blue:1.0) { didSet { uniformSettings["levelMiddle"] = middle } }
    public var maximum:Color = Color(red:1.0, green:1.0, blue:1.0) { didSet { uniformSettings["levelMaximum"] = maximum } }
    public var minOutput:Color = Color(red:0.0, green:0.0, blue:0.0) { didSet { uniformSettings["minOutput"] = minOutput } }
    public var maxOutput:Color = Color(red:1.0, green:1.0, blue:1.0) { didSet { uniformSettings["maxOutput"] = maxOutput } }

    @objc open var minimumOCColor:UIColor = UIColor(red:0.0, green:0.0, blue:0.0,alpha:1.0) { didSet { minimum = minimumOCColor.aplColorToGpuColor() } }
    @objc open var middleOCColor:UIColor = UIColor(red:1.0, green:1.0, blue:1.0,alpha:1.0) { didSet { middle = middleOCColor.aplColorToGpuColor() } }
    @objc open var maximumOCColor:UIColor = UIColor(red:1.0, green:1.0, blue:1.0,alpha:1.0) { didSet { maximum = maximumOCColor.aplColorToGpuColor() } }
    @objc open var minOutputOCColor:UIColor = UIColor(red:0.0, green:0.0, blue:0.0,alpha:1.0) { didSet { minOutput = minOutputOCColor.aplColorToGpuColor() } }
    @objc open var maxOutputOCColor:UIColor = UIColor(red:1.0, green:1.0, blue:1.0,alpha:1.0) { didSet { maxOutput = maxOutputOCColor.aplColorToGpuColor() } }
    
    // TODO: Is this an acceptable interface, or do I need to bring this closer to the old implementation?
    
    public init() {
        super.init(fragmentShader:LevelsFragmentShader, numberOfInputs:1)
        
        ({minimum = Color(red:0.0, green:0.0, blue:0.0)})()
        ({middle = Color(red:1.0, green:1.0, blue:1.0)})()
        ({maximum = Color(red:1.0, green:1.0, blue:1.0)})()
        ({minOutput = Color(red:0.0, green:0.0, blue:0.0)})()
        ({maxOutput = Color(red:1.0, green:1.0, blue:1.0)})()
    }
}
