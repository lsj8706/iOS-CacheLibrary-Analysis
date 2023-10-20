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
    func setImage(with tool: CachingTool, url: URL) {
        switch tool {
        case .`default`:
            defaultAsyncLoad(url: url)
        case .kingfisher:
            loadUsingKingfisher(url: url)
        case .sdWebImage:
            loadUsingSdWebImage(url: url)
        case .nuke:
            loadUsingNuke(url: url)
        case .alamofire:
            loadUsingAlamofireImage(url: url)
        }
    }
    
    func defaultAsyncLoad(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadUsingKingfisher(url: URL) {
        self.kf.setImage(with: url)
    }
    
    func loadUsingSdWebImage(url: URL) {
        self.sd_setImage(with: url)
    }
    
    func loadUsingNuke(url: URL) {
        ImagePipeline.shared.loadImage(with: url) { result in
            switch result {
            case .success(let imageResonse):
                self.image = imageResonse.image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUsingAlamofireImage(url: URL) {
        let imageCache = AutoPurgingImageCache()

        let urlRequest = URLRequest(url: url)
        let avatarImage = UIImage(named: url.absoluteString)!.af.imageRoundedIntoCircle()

        // Add
        imageCache.add(avatarImage, for: urlRequest, withIdentifier: url.absoluteString)

        // Fetch
        let cachedImage = imageCache.image(for: urlRequest, withIdentifier: url.absoluteString)
        self.image = cachedImage
    }
}

