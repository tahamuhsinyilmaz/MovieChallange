//
//  MovieListTableViewCell.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieListTableViewCell: UITableViewCell{
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    let viewModel = MovieListTableViewCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        createThumbnailImageView()
        createTitleLabel()
        createDescriptionLabel()
        bindData()
    }
    
    private func createThumbnailImageView(){
        thumbnailImageView.layer.cornerRadius = 7
        thumbnailImageView.clipsToBounds = true
        self.contentView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func createTitleLabel(){
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func createDescriptionLabel(){
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func bindData(){
        viewModel.dataSettedCompletion = {
            [weak self] (url, title, description) in
            self?.updateUI(url: url, title: title, description: description)
        }
    }
    
    private func updateUI(url: String, title: String, description: String){
        updateImageView(url: url)
        updateTitleLabel(title: title)
        updateDescriptionlabel(description: description)
    }
    
    private func updateImageView(url: String){
        SetImageHandler.setImage(path: url, imageView: thumbnailImageView)
    }
    
    private func updateTitleLabel(title: String){
        titleLabel.text = title
    }
    
    private func updateDescriptionlabel(description: String){
        descriptionLabel.text = description
    }
}
