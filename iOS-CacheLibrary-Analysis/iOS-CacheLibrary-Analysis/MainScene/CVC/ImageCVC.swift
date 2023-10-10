//
//  ImageCVC.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/11.
//

import UIKit

final class ImageCVC: UICollectionViewCell {
    static let identifier = "ImageCVC"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ImageCVC {
    private func setUI() {
        self.backgroundColor = .blue
    }
    
    private func setLayout() {
        
    }
}
