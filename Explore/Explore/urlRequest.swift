//
//  urlRequest.swift
//  Explore
//
//  Created by Pradyumn Bangera on 6/4/20.
//  Copyright © 2020 Pradyumn Bangera. All rights reserved.
//

import Foundation

enum CovidErrors:Error{
    case noDataAvailable
    case cannotProcessData
}

//struct statRequest{
//    let url: URL
//
//
//    init(state: String){
//        let resource: String = "https://data.cdc.gov/resource/ks3g-spdg.json?state=\(state)"
//        guard let resURL = URL(string: resource) else {fatalError()}
//
//        self.url = resURL
//    }
//
//    func getCovid(completion: @escaping(Result<[Info], CovidErrors>) -> Void){
//        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//
//            do{
//                let decoder = JSONDecoder()
//                //let resp = try decoder.decode(infoList.self, from: jsonData)
//
//                completion(.success(resp.ageGroups))
//
//            }catch{
//                completion(.failure(.cannotProcessData))
//            }
//        }
//        dataTask.resume()
//    }
//}
