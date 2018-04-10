//
//  APIClient.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/9/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import Alamofire

enum API {
    static let baseURL = URL(string: "https://api-mobile.home24.com/api/v1/articles?appDomain=1&locale=de_DE&limit=\(Constants.totalImages + 1)")! // We have to add one so the server returns 'totalImages'
}

class APIClient {
    private static var sharedAPIClient: APIClient = {
        let apiClient = APIClient(baseURL: API.baseURL)
        return apiClient
    }()
    
    let baseURL: URL
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    class func shared() -> APIClient {
        return sharedAPIClient
    }
    
    func getData(completion: @escaping (_ productArray: [Product]?) -> Void) {
        Alamofire.request(baseURL, method: .get).responseJSON { response in
            guard let json = response.result.value as? [String: AnyObject] else {
                completion(nil)
                return
            }
            guard let jsonEmbedded = json["_embedded"] as? [String: AnyObject] else {
                completion(nil)
                return
            }
            guard let articlesArray = jsonEmbedded["articles"] as? [[String: AnyObject]] else {
                completion(nil)
                return
            }
            
            let productArray = articlesArray.map { Product(withJSON: $0) }
            completion(productArray)
        }
    }
}

