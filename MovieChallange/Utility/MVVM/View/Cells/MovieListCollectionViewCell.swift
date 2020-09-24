//
//  MovieListCollectionView.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell{
    let imageView = UIImageView()
    let label = UILabel()
    let viewModel = MovieListCollectionViewCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        createImageView()
        createLabel()
        bindData()
    }
    
    private func createImageView(){
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    private func createLabel(){
        self.contentView.addSubview(label)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    private func bindData(){
        viewModel.dataSettedCompletion = {
            [weak self] (url, labelText) in
            self?.updateUI(url: url, labelText: labelText)
        }
    }
    
    private func updateUI(url: String, labelText: String){
        updateImageView(url: url)
        updateLabel(labelText: labelText)
    }
    
    private func updateImageView(url: String){
        SetImageHandler.setImage(path: url, imageView: imageView)
    }
    
    private func updateLabel(labelText: String){
        label.text = labelText
    }
}
