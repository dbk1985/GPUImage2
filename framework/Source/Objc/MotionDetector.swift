import Foundation
import UIKit

public class MotionDetector: OperationGroup {
    @objc open var lowPassStrength:Float = 1.0 { didSet {lowPassFilter.strength = lowPassStrength}}
    public var motionDetectedCallback:((Position, Float) -> ())?
    @objc open var motionDetectedOCCallback:((UIColor) -> ())? {
        didSet {
            if motionDetectedOCCallback != nil {
                motionDetectedCallback = { (color, alpha) in
                    let r = color.x
                    let g = color.y
                    let b = color.z
                    self.motionDetectedOCCallback!(UIColor(red:CGFloat(r), green:CGFloat(g), blue:CGFloat(b!), alpha:CGFloat(alpha)))
                }
            }else {
                motionDetectedCallback = nil
            }
        }
    }
    
    let lowPassFilter = LowPassFilter()
    let motionComparison = BasicOperation(fragmentShader:MotionComparisonFragmentShader, numberOfInputs:2)
    let averageColorExtractor = AverageColorExtractor()
    
    public override init() {
        super.init()
        
        averageColorExtractor.extractedColorCallback = {[weak self] color in
            self?.motionDetectedCallback?(Position(color.redComponent / color.alphaComponent, color.greenComponent / color.alphaComponent), color.alphaComponent)
        }
        
        self.configureGroup{input, output in
            input --> self.motionComparison --> self.averageColorExtractor --> output
            input --> self.lowPassFilter --> self.motionComparison
        }
    }
}
