//
//  BusinessService.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit
import Alamofire

class BusinessService {
    
    typealias businessCallBack = (_ business: [BusinessDataModel]?, _ status: Bool, _ message: String) -> Void
    
    var callBack: businessCallBack?
    
    private let baseUrl: String = "https://prod.klikin.com/commerces/public"
    
    //MARK: - Methods
    func getBusiness() {
        UIApplication.shared.showLoading()

        AF.request(baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responseData in
            print("We got the response")
            guard let data = responseData.data else {
                self.callBack?(nil,false,"Error data")
                return }
            do {
                let business = try JSONDecoder().decode([BusinessDataModel].self, from: data)
                self.callBack?(business, true, "")
            } catch {
                self.callBack?(nil, false, "\(error.localizedDescription)")
            }
            UIApplication.shared.hideLoading()

        }
    }
    
    func completionHandler(callBack: @escaping businessCallBack) {
        self.callBack = callBack
    }
}
