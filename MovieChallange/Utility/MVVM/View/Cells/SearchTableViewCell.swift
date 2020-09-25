//
//  SearchTableViewCell.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell{
    let viewModel = SearchTableViewCellViewModel()
    let arrowImageView = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        createArrowImageView()
        createLabel()
        bindData()
    }
    
    private func createLabel(){
        self.contentView.addSubview(label)
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: self.arrowImageView.leadingAnchor),
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    private func createArrowImageView(){
        arrowImageView.image = UIImage(named: "rightArrow")
        self.contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            arrowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    private func bindData(){
        viewModel.completion = {
            [weak self] (title, date) in
            self?.updateUI(title: title, date: date)
        }
    }
    
    private func updateUI(title:String, date: String){
        let dateComponents = date.split(separator: "-")
        let year = dateComponents.first ?? ""
        label.text = "\(title) (\(year))"
    }
}
