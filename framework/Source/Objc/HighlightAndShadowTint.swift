import Foundation
import UIKit

public class HighlightAndShadowTint: BasicOperation {
    @objc open var shadowTintIntensity:Float = 0.0 { didSet { uniformSettings["shadowTintIntensity"] = shadowTintIntensity } }
    @objc open var highlightTintIntensity:Float = 0.0 { didSet { uniformSettings["highlightTintIntensity"] = highlightTintIntensity } }
    public var shadowTintColor:Color = Color.red { didSet { uniformSettings["shadowTintColor"] = shadowTintColor } }
    public var highlightTintColor:Color = Color.blue { didSet { uniformSettings["highlightTintColor"] = highlightTintColor } }
    @objc open var shadowTintOCColor: UIColor = UIColor.red {
        didSet {
            shadowTintColor = shadowTintOCColor.aplColorToGpuColor()
        }
    }
    @objc open var highlightTintOCColor: UIColor = UIColor.blue {
        didSet {
            highlightTintColor = highlightTintOCColor.aplColorToGpuColor()
        }
    }
    
    public init() {
        super.init(fragmentShader:HighlightShadowTintFragmentShader, numberOfInputs:1)
        
        ({shadowTintIntensity = 0.0})()
        ({highlightTintIntensity = 0.0})()
        ({shadowTintColor = Color.red})()
        ({highlightTintColor = Color.blue})()
    }
}
