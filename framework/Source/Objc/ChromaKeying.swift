import Foundation
import UIKit
public class ChromaKeying: BasicOperation {
    @objc open var thresholdSensitivity:Float = 0.4 { didSet { uniformSettings["thresholdSensitivity"] = thresholdSensitivity } }
    @objc open var smoothing:Float = 0.1 { didSet { uniformSettings["smoothing"] = smoothing } }
    public var colorToReplace:Color = Color.green { didSet { uniformSettings["colorToReplace"] = colorToReplace } }
    @objc open var colorToReplaceForOC:UIColor = UIColor.green { didSet { colorToReplace = colorToReplaceForOC.aplColorToGpuColor() } }
    
    public init() {
        super.init(fragmentShader:ChromaKeyFragmentShader, numberOfInputs:1)
        
        ({thresholdSensitivity = 0.4})()
        ({smoothing = 0.1})()
        ({colorToReplace = Color.green})()
    }
}
