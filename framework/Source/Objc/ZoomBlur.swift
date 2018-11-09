import Foundation
import CoreGraphics

public class ZoomBlur: BasicOperation {
    @objc open var blurSize:Float = 1.0 { didSet { uniformSettings["blurSize"] = blurSize } }
    public var blurCenter:Position = Position.center { didSet { uniformSettings["blurCenter"] = blurCenter } }
    @objc open var ocBlurCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) { didSet { blurCenter = Position(point: ocBlurCenter) } }
    
    public init() {
        super.init(fragmentShader:ZoomBlurFragmentShader, numberOfInputs:1)
        
        ({blurSize = 1.0})()
        ({blurCenter = Position.center})()
    }
}
