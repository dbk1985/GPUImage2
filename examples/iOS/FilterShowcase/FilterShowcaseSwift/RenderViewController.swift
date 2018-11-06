//
//  RenderViewController.swift
//  FilterShowcase
//
//  Created by wzkj on 2018/11/1.
//  Copyright © 2018 Sunset Lake Software. All rights reserved.
//

import UIKit
import CoreImage
import GPUImage_iOS_OC

public class RenderViewController : UIViewController
{
    @IBOutlet weak var renderView: RenderView!
    
    var picture:PictureInput!
    var filter:SaturationAdjustment!
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        // Filtering image for saving
//        let testImage = UIImage(named:"testimage.jpg")!
//        let toonFilter = SmoothToonFilter()
//        let filteredImage = testImage.filterWithOperation(toonFilter)
//
//        let pngImage = UIImagePNGRepresentation(filteredImage)!
//        do {
//            let documentsDir = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
//            let fileURL = URL(string:"test.png", relativeTo:documentsDir)!
//            try pngImage.write(to:fileURL, options:.atomic)
//        } catch {
//            print("Couldn't write to file with error: \(error)")
//        }
        
        // Filtering image for display
        picture = PictureInput(image:UIImage(named:"testimage.jpg")!)
        filter = SaturationAdjustment()
        let gammaFilter = GammaAdjustment()
        let husFilter = HueAdjustment()
        husFilter.hue = 270
        let monoFilter: DZCIFilter = DZCIFilter(filter: CIFilter(name: "CIPhotoEffectMono")!)
        let sharpFilter: Sharpen = Sharpen()
        sharpFilter.sharpness = 0.9
        
        picture --> filter --> gammaFilter --> monoFilter --> sharpFilter --> husFilter --> renderView
        picture.processImage()
    }
}
