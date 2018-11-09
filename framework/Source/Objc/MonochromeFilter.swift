import Foundation
import UIKit

public class MonochromeFilter: BasicOperation {
    @objc open var intensity:Float = 1.0 { didSet { uniformSettings["intensity"] = intensity } }
    public var color:Color = Color(red:0.6, green:0.45, blue:0.3, alpha:1.0) { didSet { uniformSettings["filterColor"] = color } }
   
    @objc open var occolor: UIColor = UIColor(red:0.6, green:0.45, blue:0.3, alpha:1.0) { didSet { color = occolor.aplColorToGpuColor()} }
    
    public init() {
        super.init(fragmentShader:MonochromeFragmentShader, numberOfInputs:1)
        
        ({intensity = 1.0})()
        ({color = Color(red:0.6, green:0.45, blue:0.3, alpha:1.0)})()
    }
}
