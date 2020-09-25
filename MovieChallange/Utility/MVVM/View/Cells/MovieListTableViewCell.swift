//
//  MovieListTableViewCell.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieListTableViewCell: UITableViewCell{
    private let thumbnailImageView = UIImageView()
    private let rightArrowImageView = UIImageView(image: UIImage(named: "rightArrow"))
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
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
        self.selectionStyle = .none
        createThumbnailImageView()
        createRightArrowImageView()
        createTitleLabel()
        createDescriptionLabel()
        createDateLabel()
        bindData()
    }
    
    private func createThumbnailImageView(){
        thumbnailImageView.layer.cornerRadius = 7
        thumbnailImageView.clipsToBounds = true
        self.contentView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func createRightArrowImageView(){
        self.contentView.addSubview(rightArrowImageView)
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightArrowImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            rightArrowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 20),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func createTitleLabel(){
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rightArrowImageView.leadingAnchor, constant: -5)
        ])
    }
    
    private func createDescriptionLabel(){
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 4
        descriptionLabel.textColor = .gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        ])
    }
    
    private func createDateLabel(){
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func bindData(){
        viewModel.dataSettedCompletion = {
            [weak self] (url, title, description, date) in
            self?.updateUI(url: url, title: title, description: description, date: date)
        }
    }
    
    private func updateUI(url: String, title: String, description: String, date: String){
        updateImageView(url: url)
        updateTitleLabel(title: title, date: date)
        updateDescriptionlabel(description: description)
        updateDateLabel(date: date)
    }
    
    private func updateImageView(url: String){
        SetImageHandler.setImage(path: url, imageView: thumbnailImageView)
    }
    
    private func updateTitleLabel(title: String, date: String){
        let dateComponents = date.split(separator: "-")
        let year = dateComponents.first ?? ""
        titleLabel.text = "\(title) (\(year))"
    }
    
    private func updateDescriptionlabel(description: String){
        descriptionLabel.text = description
    }
    
    private func updateDateLabel(date: String){
        let dateComponents = date.split(separator: "-")
        let year = dateComponents.first ?? ""
        let month = dateComponents[1]
        let day = dateComponents.last ?? ""
        dateLabel.text = "\(day).\(month).\(year)"
    }
}
