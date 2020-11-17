//
//  DataOperation.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import UIKit
import Alamofire

class DataOperation: NSObject {
    
    // MARK: - Public properties
    
    var request: DataRequest?
    var operationQueue: OperationQueue?
    
    // MARK: - Init
    
    init(request: DataRequest?) {
        super.init()
        self.request = request
    }
    
    init(operationQueue: OperationQueue) {
        super.init()
        self.operationQueue = operationQueue
    }
    
    // MARK: - Public methods
    
    func cancel() {
        request?.cancel()
        request = nil
        operationQueue?.cancelAllOperations()
        operationQueue = nil
    }
    
}

