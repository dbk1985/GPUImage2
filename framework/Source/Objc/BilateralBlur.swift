// TODO: auto-generate shaders for this, per the Gaussian blur method
import Foundation
public class BilateralBlur: TwoStageOperation {
    @objc open var distanceNormalizationFactor:Float = 8.0 { didSet { uniformSettings["distanceNormalizationFactor"] = distanceNormalizationFactor } }
    
    public init() {
        super.init(vertexShader:BilateralBlurVertexShader, fragmentShader:BilateralBlurFragmentShader)
        
        ({distanceNormalizationFactor = 1.0})()
    }
}
