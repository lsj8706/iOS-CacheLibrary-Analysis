//
//  ImageCVC.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/11.
//

import UIKit

final class ImageCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ImageCVC"
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - initialization
    
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
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setImageView(with url: URL?, tool: CachingTool) {
        guard let url = url else { return }
        self.imageView.setImage(with: tool, url: url)
    }
}
