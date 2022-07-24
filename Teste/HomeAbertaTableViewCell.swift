//
//  HomeAbertaTableViewCell.swift
//  Teste
//
//  Created by Josicleison on 24/07/22.
//

import UIKit

class HomeAbertaTableViewCell: UITableViewCell {
    
    lazy var photosCollecrionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 64, height: 64)
        
        let photosCollecrionView = UICollectionView(frame: contentView.frame,
                                                    collectionViewLayout: collectionViewLayout)
        photosCollecrionView.backgroundColor = .cyan
        photosCollecrionView.layer.cornerRadius = 12
        photosCollecrionView.register(HomeAbertaCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        return photosCollecrionView
    }()
    
    let viewElements: (view: UIView, titleLabel: UILabel, descriptionLabel: UILabel) = {
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .systemGreen
        titleLabel.text = "BOXOFFICE"
        
        let descriptionLabel = UILabel()
        
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 12
        
        view.addSubviews([titleLabel, descriptionLabel])
        
        return (view: view, titleLabel: titleLabel, descriptionLabel: descriptionLabel)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupDefaults()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        contentView.addSubviews([viewElements.view])
        contentView.setToDefaultBackgroundColor()
        
        viewElements.view.addSubview(photosCollecrionView)
        
        photosCollecrionView.delegate = self
        photosCollecrionView.dataSource = self
    }
    
    func setupDefaults() {
        
        viewElements.descriptionLabel.setToDefault(text: "Numa esquina charmosa, um hotel",
                                                   .left)
    }
    
    func setupConstraints() {
        
        viewElements.view.fillSuperview()
//        viewElements.view.heightAnchorInSuperview(100)
        
        viewElements.titleLabel.constraintInsideTo(.top, viewElements.view)
        viewElements.titleLabel.constraintInsideTo(.leading, viewElements.view, 21)
        
        viewElements.descriptionLabel.constraintOutsideTo(.top, viewElements.titleLabel, 23)
        viewElements.descriptionLabel.constraintInsideTo(.leading, viewElements.titleLabel)
        viewElements.descriptionLabel.widthAnchorInSuperview(215)
        
        photosCollecrionView.constraintOutsideTo(.top, viewElements.descriptionLabel, 22)
        photosCollecrionView.constraintInsideTo(.leading, viewElements.descriptionLabel)
        photosCollecrionView.constraintInsideTo(.trailing, viewElements.view)
        photosCollecrionView.heightAnchorInSuperview(100)
        photosCollecrionView.constraintInsideTo(.bottom, viewElements.view, 21)
    }
}

extension HomeAbertaTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = photosCollecrionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}
