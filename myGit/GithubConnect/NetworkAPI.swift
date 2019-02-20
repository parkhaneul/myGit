//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Alamofire
import RxSwift
import Foundation

public typealias completionType = (Data?,URLResponse?,Error?) -> Swift.Void

struct NetworkAPI{
    static let shared = NetworkAPI()
    
    public func get(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil) -> Observable<DataResponse<Any>>{
        return Observable.create{ observer -> Disposable in
            AF.request(url, parameters : parameters, headers : HTTPHeaders(headers ?? [:]))
            .validate(statusCode: 200..<300)
            .responseJSON{ JSON in
                observer.onNext(JSON)
            }
            return Disposables.create()
        }
    }
    
    public func post(url : String, parameters : [String : String]? = nil, headers : [String : String]? = nil) -> Observable<DataResponse<Any>>{
        return Observable.create{ observer -> Disposable in
            AF.request(url, method : .post, parameters : parameters, headers : HTTPHeaders(headers ?? [:]))
            .validate(statusCode: 200..<300)
            .responseJSON{ JSON in
                observer.onNext(JSON)
            }
            return Disposables.create()
        }
    }
}
