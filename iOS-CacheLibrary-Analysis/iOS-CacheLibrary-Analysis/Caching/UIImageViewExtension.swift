//
//  UIImageViewExtension.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/11.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with tool: CachingTool, url: URL) {
        switch tool {
        case .`default`:
            defaultAsyncLoad(url: url)
        case .kingfisher:
            loadUsingKingfisher(url: url)
        case .sdWebImage:
            break
        case .nuke:
            break
        case .alamofire:
            break
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
}

