//
//  SetImageHandler.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import Kingfisher
import UIKit

class SetImageHandler{
    class func setImage(path: String, imageView: UIImageView){
        let completeUrl = Constants.shared.baseImageUrl + path
        guard let url = URL(string: completeUrl) else {return}
        imageView.kf.setImage(with: url)
    }
}
