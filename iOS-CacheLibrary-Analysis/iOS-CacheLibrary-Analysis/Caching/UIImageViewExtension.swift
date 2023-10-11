//
//  UIImageViewExtension.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/11.
//

import UIKit

extension UIImageView {
    func setImage(with tool: CachingTool, url: URL) {
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
}

