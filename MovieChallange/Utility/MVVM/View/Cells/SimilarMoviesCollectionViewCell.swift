//
//  SimilarMoviesCollectionViewCell.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    let viewModel = SimilarMoviesCollectionViewCellViewModel()
    let imageView = UIImageView()
    let label = UILabel()
    
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
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
    private func createLabel(){
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    private func bindData(){
        viewModel.completion = {
            [weak self] (path, title, date) in
            self?.updateUI(path: path, title: title, date: date)
        }
    }
    
    private func updateUI(path: String, title: String, date: String){
        updateImageView(path: path)
        updateLabel(title: title, date: date)
    }
    
    private func updateImageView(path: String){
        SetImageHandler.setImage(path: path, imageView: imageView)
    }
    
    private func updateLabel(title: String, date: String){
        label.text = title + "\n" + date
    }
}
