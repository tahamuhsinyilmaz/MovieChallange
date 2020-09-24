//
//  NetworkHandler.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import Alamofire

class NetworkHandler{
    class func sendRequest(url: String, completion: @escaping (_ data : AFDataResponse<Data>?, _ error: Error?) -> Void){
        let params = ["api_key": Constants.shared.apiKey]
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString)).validate(contentType: ["application/json"])
        .responseData(completionHandler: { (response) in
            guard response.data != nil else {
                completion(nil, nil)
                return
            }
            completion(response, nil)
            })
    }
}
