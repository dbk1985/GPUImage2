//
//  RenderImageView.swift
//  GPUImage_iOS_OC
//
//  Created by wzkj on 2018/11/1.
//  Copyright © 2018 Sunset Lake Software LLC. All rights reserved.
//

import UIKit

public enum GeneratedPictureFormat {
    case unknown
    case image
    case pngData
    case jpegData
}

open class RenderImageView : UIImageView, ImageConsumer {
    public var backgroundRenderColor = Color.black
    public var fillMode = FillMode.preserveAspectRatio
    public var orientation:ImageOrientation = .portrait
    public var sizeInPixels:Size { get { return Size(width:Float(frame.size.width * contentScaleFactor), height:Float(frame.size.height * contentScaleFactor))}}
    
    public let sources = SourceContainer()
    public let maximumInputs:UInt = 1
    var displayFramebuffer:GLuint?
    var displayRenderbuffer:GLuint?
    var backingSize = GLSize(width:0, height:0)
   
    public var fetchImageDataCallback:(() -> (encodedImageFormatCallback:() -> GeneratedPictureFormat,onlyCaptureNextFrameCallback:() -> Bool,imageDataCallback:(Any/** UIImage or Data */) -> ()))?
    public var keepImageAroundForSynchronousCapture:Bool = false
    var storedFramebuffer:Framebuffer?
    
    private lazy var displayShader:ShaderProgram = {
        return sharedImageProcessingContext.passthroughShader
    }()
    
    // TODO: Need to set viewport to appropriate size, resize viewport on view reshape
    
    required public init?(coder:NSCoder) {
        super.init(coder:coder)
        self.commonInit()
    }
    
    public override init(frame:CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
   
    public override init(image: UIImage?) {
        super.init(image: image)
        self.commonInit()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.commonInit()
    }
    
    override open class var layerClass:Swift.AnyClass {
        get {
            return CAEAGLLayer.self
        }
    }
    
    func commonInit() {
        if (self.backgroundColor != nil) {
            self.backgroundRenderColor = self.backgroundColor!.aplColorToGpuColor();
        }
        self.contentScaleFactor = UIScreen.main.scale
        
        let eaglLayer = self.layer as! CAEAGLLayer
        eaglLayer.isOpaque = true
        eaglLayer.drawableProperties = [String(describing: NSNumber(value:false)): kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8: kEAGLDrawablePropertyColorFormat]
    }
    
    deinit {
        destroyDisplayFramebuffer()
    }
    
    func createDisplayFramebuffer() {
        var newDisplayFramebuffer:GLuint = 0
        glGenFramebuffers(1, &newDisplayFramebuffer)
        displayFramebuffer = newDisplayFramebuffer
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), displayFramebuffer!)
        
        var newDisplayRenderbuffer:GLuint = 0
        glGenRenderbuffers(1, &newDisplayRenderbuffer)
        displayRenderbuffer = newDisplayRenderbuffer
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), displayRenderbuffer!)
        
        sharedImageProcessingContext.context.renderbufferStorage(Int(GL_RENDERBUFFER), from:self.layer as! CAEAGLLayer)
        
        var backingWidth:GLint = 0
        var backingHeight:GLint = 0
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_WIDTH), &backingWidth)
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_HEIGHT), &backingHeight)
        backingSize = GLSize(width:backingWidth, height:backingHeight)
        
        guard ((backingWidth > 0) && (backingHeight > 0)) else {
            fatalError("View had a zero size")
        }
        
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), displayRenderbuffer!)
        
        let status = glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER))
        if (status != GLenum(GL_FRAMEBUFFER_COMPLETE)) {
            fatalError("Display framebuffer creation failed with error: \(FramebufferCreationError(errorCode:status))")
        }
    }
    
    func destroyDisplayFramebuffer() {
        sharedImageProcessingContext.runOperationSynchronously{
            if let displayFramebuffer = self.displayFramebuffer {
                var temporaryFramebuffer = displayFramebuffer
                glDeleteFramebuffers(1, &temporaryFramebuffer)
                self.displayFramebuffer = nil
            }
            
            if let displayRenderbuffer = self.displayRenderbuffer {
                var temporaryRenderbuffer = displayRenderbuffer
                glDeleteRenderbuffers(1, &temporaryRenderbuffer)
                self.displayRenderbuffer = nil
            }
        }
    }
    
    func activateDisplayFramebuffer() {
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), displayFramebuffer!)
        glViewport(0, 0, backingSize.width, backingSize.height)
    }
    
    public func newFramebufferAvailable(_ framebuffer:Framebuffer, fromSourceIndex:UInt) {
        if (displayFramebuffer == nil) {
            self.createDisplayFramebuffer()
        }
        
        if keepImageAroundForSynchronousCapture {
            storedFramebuffer?.unlock()
            storedFramebuffer = framebuffer
        }

        self.activateDisplayFramebuffer()
        
        clearFramebufferWithColor(backgroundRenderColor)
        
        let scaledVertices = fillMode.transformVertices(verticallyInvertedImageVertices, fromInputSize:framebuffer.sizeForTargetOrientation(self.orientation), toFitSize:backingSize)
        renderQuadWithShader(self.displayShader, vertices:scaledVertices, inputTextures:[framebuffer.texturePropertiesForTargetOrientation(self.orientation)])
        
        if let imageCallback = fetchImageDataCallback {
            let imageByteSize = Int(framebuffer.size.width * framebuffer.size.height * 4)
            let data = UnsafeMutablePointer<UInt8>.allocate(capacity: imageByteSize)
            glReadPixels(0, 0, framebuffer.size.width, framebuffer.size.height, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), data)
            
            framebuffer.unlock()
            
            guard let dataProvider = CGDataProvider(dataInfo:nil, data:data, size:imageByteSize, releaseData: dataProviderReleaseCallback) else {fatalError("Could not allocate a CGDataProvider")}
            let defaultRGBColorSpace = CGColorSpaceCreateDeviceRGB()
            let cgImageFromBytes = CGImage(width:Int(framebuffer.size.width), height:Int(framebuffer.size.height), bitsPerComponent:8, bitsPerPixel:32, bytesPerRow:4 * Int(framebuffer.size.width), space:defaultRGBColorSpace, bitmapInfo:CGBitmapInfo() /*| CGImageAlphaInfo.Last*/, provider:dataProvider, decode:nil, shouldInterpolate:false, intent:.defaultIntent)!
            let image = UIImage(cgImage:cgImageFromBytes, scale:1.0, orientation:.up)
            let (encodedImageFormatCallback, onlyCaptureNextFrameCallback, imageDataCallback) = imageCallback()
            
            var encodedImageFormat:GeneratedPictureFormat = .unknown
            encodedImageFormat = encodedImageFormatCallback()
            switch encodedImageFormat {
            case .unknown, .image:
                imageDataCallback(image)
                break
            case .pngData:
                let imageData:Data = UIImagePNGRepresentation(image)! // TODO: Better error handling here
                imageDataCallback(imageData)
            case .jpegData:
                let imageData:Data = UIImageJPEGRepresentation(image, 0.8)! // TODO: Be able to set image quality
                imageDataCallback(imageData)
            }
            
            let onlyCaptureNextFrame = onlyCaptureNextFrameCallback()
            
            if onlyCaptureNextFrame {
                fetchImageDataCallback = nil
            }
        }
        
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), displayRenderbuffer!)
        sharedImageProcessingContext.presentBufferForDisplay()
    }

//    public func synchronousImageCapture() -> UIImage {
//        var outputImage:UIImage!
//        sharedImageProcessingContext.runOperationSynchronously{
//            guard let currentFramebuffer = storedFramebuffer else { fatalError("Synchronous access requires keepImageAroundForSynchronousCapture to be set to true") }
//
//            let cgImageFromBytes = cgImageFromFramebuffer(currentFramebuffer)
//            outputImage = UIImage(cgImage:cgImageFromBytes, scale:1.0, orientation:.up)
//        }
//
//        return outputImage
//    }
    
}
