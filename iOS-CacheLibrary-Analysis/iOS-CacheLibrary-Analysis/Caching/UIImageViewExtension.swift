//
//  UIImageViewExtension.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/11.
//

import UIKit
import Kingfisher
import SDWebImage
import Nuke
import AlamofireImage

extension UIImageView {

    var pixelSize: CGFloat {
      return 65.0 * UIScreen.main.scale
    }

    var resizedImageProcessors: [ImageProcessing] {
      let imageSize = CGSize(width: pixelSize, height: pixelSize)
      return [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
    }
    
    func setImage(with tool: CachingTool, url: URL, startTime: CFAbsoluteTime) {
        switch tool {
        case .`default`:
            defaultAsyncLoad(url: url, startTime: startTime)
        case .kingfisher:
            loadUsingKingfisher(url: url, startTime: startTime)
        case .sdWebImage:
            loadUsingSdWebImage(url: url, startTime: startTime)
        case .nuke:
            loadUsingNuke(url: url, startTime: startTime)
        case .alamofire:
            loadUsingAlamofireImage(url: url, startTime: startTime)
        }
    }
    
    func defaultAsyncLoad(url: URL, startTime: CFAbsoluteTime) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.printProgressTime(startTime: startTime)
                    }
                }
            }
        }
    }
    
    func loadUsingKingfisher(url: URL, startTime: CFAbsoluteTime) {
        self.kf.setImage(with: url) { [weak self] result in
            self?.printProgressTime(startTime: startTime)
        }
    }
    
    func loadUsingSdWebImage(url: URL, startTime: CFAbsoluteTime) {
        self.sd_setImage(with: url) { [weak self] _, _, _, _ in
            self?.printProgressTime(startTime: startTime)
        }
    }
    
    func loadUsingNuke(url: URL, startTime: CFAbsoluteTime) {
        let request = ImageRequest(url: url, processors: resizedImageProcessors)
        
        ImagePipeline.shared.loadImage(with: request) { _, _, _ in
        } completion: { [weak self] result in
            switch result {
            case .success(let imageResonse):
                self?.printProgressTime(startTime: startTime)
                self?.image = imageResonse.image
            case .failure(let error):
                print(error)
            }
        }

        
//        ImagePipeline.shared.loadImage(with: url) { [weak self] result in
//            switch result {
//            case .success(let imageResonse):
//                self?.printProgressTime(startTime: startTime)
//                self?.image = imageResonse.image
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func loadUsingAlamofireImage(url: URL, startTime: CFAbsoluteTime) {
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: CGSize(width: pixelSize, height: pixelSize),
            radius: 5.0
        )
        
        self.af.setImage(withURL: url, filter: filter, completion:  { [weak self] _ in
            self?.printProgressTime(startTime: startTime)
        })
    }
    
    func printProgressTime(startTime: CFAbsoluteTime) {
        let endTime = CFAbsoluteTimeGetCurrent()
        let diff = endTime - startTime
        print(diff)
    }
}

