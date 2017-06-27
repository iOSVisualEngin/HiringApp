//
//  APIProvider.swift
//  Pods
//
//  Created by Alba Luján on 21/6/17.
//
//

import Foundation
import BSWFoundation
import Deferred
import Decodable
import KeychainSwift

enum APIError: Error {
    case badStatusCode
    case errorWhileParsing
    case responseUnexpected
}

protocol DroskyType {
    func performRequest(forEndpoint endpoint: Endpoint) -> Task<DroskyResponse>
}

extension Drosky: DroskyType {}

protocol APIProviderType {
    func retrieveTechnologies() -> Task<[TechnologyModel]>
}

class APIProvider: APIProviderType {
    
    let drosky: DroskyType
    
    init(drosky: DroskyType = Drosky(environment: DevelopmentEnvironment())) {
        self.drosky = drosky
    }
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        
        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: AppEndpoints.technologies)
        
        //check the status code of the response
        let statusCodeTask = droskyTask.andThen(upon: .global()) { (droskyResponse) -> Task<Data> in
            //Check if status code is in range od 200s
            guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
                return Task(failure: APIError.badStatusCode)
            }
            
            return Task(success: droskyResponse.data)
        }
        
        //parse the data of the response and return a model
        let modelTask = statusCodeTask.andThen(upon: .global()) { (data) -> Task<[TechnologyModel]> in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let model = try [TechnologyModel].decode(json)
                return Task(success: model)
            } catch {
                return Task(failure: APIError.errorWhileParsing)
            }
        }
        return modelTask
    }
    
    func performLogin() -> Task<String> {
        
        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: AppEndpoints.authenticate)
        
        //check the status code of the response
        let statusCodeTask = droskyTask.andThen(upon: .global()) { (droskyResponse) -> Task<Data> in
            //Check if status code is in range od 200s
            guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
                return Task(failure: APIError.badStatusCode)
            }
            
            return Task(success: droskyResponse.data)
        }
        
        //parse the data of the response and return a model
        let modelTask = statusCodeTask.andThen(upon: .global()) { (data) -> Task<String> in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>
                guard let token = json?["authToken"] as? String else {
                    return Task(failure: APIError.errorWhileParsing)
                }
                
                let keychain = KeychainSwift()
                keychain.set(token, forKey: "userToken")
                return Task(success: token)
            } catch {
                return Task(failure: APIError.errorWhileParsing)
            }
        }
        return modelTask
    }
    
    
    func performContact(candidate: CandidateModel) -> Task<()> {
        
        let endpoint = AppEndpoints.candidate(parameters: candidate.dict as [String : AnyObject])

        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: endpoint)
        
        //check the status code of the response
        let finalTask = droskyTask.andThen(upon: .global()) { (droskyResponse) -> Task<()> in
            //Check if status code is in range od 200s
            guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
                return Task(failure: APIError.badStatusCode)
            }
            return Task(success: (()))
        }
        return finalTask
    }
    
    func retrieveTopics(technologyId: Int) -> Task<[TopicModel]> {
        
        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: AppEndpoints.topics(technologyId: technologyId))
        
        //check the status code of the response
        let statusCodeTask = droskyTask.andThen(upon: .global()) { (droskyResponse) -> Task<Data> in
            //Check if status code is in range od 200s
            guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
                return Task(failure: APIError.badStatusCode)
            }
            
            return Task(success: droskyResponse.data)
        }
        
        //parse the data of the response and return a model
        let modelTask = statusCodeTask.andThen(upon: .global()) { (data) -> Task<[TopicModel]> in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let model = try [TopicModel].decode(json)
                return Task(success: model)
            } catch {
                return Task(failure: APIError.errorWhileParsing)
            }
        }
        return modelTask
    }
}
