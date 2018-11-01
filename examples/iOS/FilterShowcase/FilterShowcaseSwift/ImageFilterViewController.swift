//
//  ImageFilterViewController.swift
//  FilterShowcase
//
//  Created by wzkj on 2018/11/1.
//  Copyright © 2018 Sunset Lake Software. All rights reserved.
//

import UIKit
import GPUImage_iOS_OC
import AVFoundation

public class ImageFilterViewController : UIViewController{
    @IBOutlet weak var imageRenderView: RenderImageView!

    var picture:PictureInput!
    var filter:SaturationAdjustment!
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageRenderView.contentMode = .scaleAspectFit
        imageRenderView.image = #imageLiteral(resourceName: "testimage.jpg")
        if !self.view.isUserInteractionEnabled {
            self.view.isUserInteractionEnabled = true
            let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageFilterViewController.filterAction))
            gesture.numberOfTapsRequired = 1
            gesture.numberOfTouchesRequired = 1
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func filterAction() -> Void {
        picture = PictureInput(image: imageRenderView.image!)
        filter = SaturationAdjustment()
        let mono:MonochromeFilter = MonochromeFilter()
        
        picture --> filter --> mono --> imageRenderView
        picture.processImage()
    }
}
