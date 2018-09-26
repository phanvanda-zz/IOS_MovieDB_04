//
//  APIService.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RxSwift

struct APIService {
    static let share = APIService()
    
    private var alamofireManager = Alamofire.SessionManager.default
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.adapter = CustomRequestAdapter()
    }
    
    func request<T: Mappable>(input: BaseRequest) -> Observable<T> {
        return Observable.create{ observer in
            print("\n------------REQUEST INPUT")
            print("link: %@", input.url)
            print("body: %@", input.body ?? "No Body")
            print("------------ END REQUEST INPUT\n")
            self.alamofireManager.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
                .validate(statusCode: 200..<500)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let statusCode = response.response?.statusCode else {
                            observer.onError(BaseError.unexpectedError)
                            return
                        }
                        if statusCode == 200 {
                            let object = Mapper<T>().map(JSONObject: value)
                            observer.onNext(object!)
                            return
                        } else {
                            guard let object = Mapper<ErrorResponse>().map(JSONObject: value) else {
                                observer.onError(BaseError.httpError(httpCode: statusCode))
                                return
                            }
                            observer.onError(BaseError.apiFailure(error: object))
                        }
                        break
                    case .failure:
                        observer.onError(BaseError.networkError)
                    }
                    observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
