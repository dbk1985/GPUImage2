import Foundation
import CoreGraphics

public class Sharpen: BasicOperation {
    @objc open var sharpness:Float = 0.0 { didSet { uniformSettings["sharpness"] = sharpness } }
    public var overriddenTexelSize:Size?
    @objc open var overriddenTexelOCSize:CGSize = CGSize.zero {
        didSet {
            if overriddenTexelOCSize.equalTo(CGSize.zero) {
                overriddenTexelSize = nil
            }else {
                overriddenTexelSize = Size(width: Float((overriddenTexelOCSize.width)), height: Float((overriddenTexelOCSize.height)))
            }
        }
    }
    
    public init() {
        super.init(vertexShader:SharpenVertexShader, fragmentShader:SharpenFragmentShader, numberOfInputs:1)
        
        ({sharpness = 0.0})()
    }
    
    override func configureFramebufferSpecificUniforms(_ inputFramebuffer:Framebuffer) {
        let outputRotation = overriddenOutputRotation ?? inputFramebuffer.orientation.rotationNeededForOrientation(.portrait)
        let texelSize = overriddenTexelSize ?? inputFramebuffer.texelSize(for:outputRotation)
        uniformSettings["texelWidth"] = texelSize.width
        uniformSettings["texelHeight"] = texelSize.height
    }
}
