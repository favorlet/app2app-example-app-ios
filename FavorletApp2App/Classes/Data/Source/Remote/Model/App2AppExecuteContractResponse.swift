//
//  App2AppExecuteContractResponse.swift
//  App2AppExample
//
//  Created by evahpirazzi on 2022/11/28.
//

import Foundation

public struct App2AppExecuteContractResponse: Decodable {
    public var requestId: String?
    public var expiredAt: Int?
    public var error: App2AppError?
}
