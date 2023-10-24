//
//  ViewController.swift
//  iOS-CacheLibrary-Analysis
//
//  Created by sejin on 2023/10/06.
//

import UIKit

final class MainVC: UIViewController {
    
    // MARK: - Properties
    
    private let images = Images.imageURLs
    private let collectionViewInset: CGFloat = 10
    
    // MARK: - UI Components
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
        
    lazy var scrollButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "스크롤", style: .plain, target: self, action: #selector(scrollButtonDidTap))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.setCollectionView()
    }
}

// MARK: - Methods

extension MainVC {
    private func setNavigation() {
        self.title = "이미지 캐싱"
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = scrollButton
    }
    
    private func setLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setCollectionView() {
        self.collectionView.register(ImageCVC.self, forCellWithReuseIdentifier: ImageCVC.identifier)
    }
    
    @objc
    private func scrollButtonDidTap(sender: UIBarItem) {
        let collectionViewHeight = collectionView.frame.height
        let contentHeight = collectionView.contentSize.height
        let diff = contentHeight - collectionViewHeight
        let offset = CGPoint(x: 0, y: diff)
        collectionView.setContentOffset(offset, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MainVC: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCVC.identifier, for: indexPath) as? ImageCVC
        else { return UICollectionViewCell() }
        let url = URL(string: images[indexPath.item])
        cell.setImageView(with: url, tool: .kingfisher)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 2*collectionViewInset) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewInset
    }
}
