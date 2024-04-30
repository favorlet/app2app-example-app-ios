//
//  App2AppConnectWalletAndSignMessageResponse.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 10/17/23.
//

import Foundation

public struct App2AppConnectWalletAndSignMessageResponse: Decodable {
    public var requestId: String?
    public var expiredAt: Int?
    public var error: App2AppError?
}
