//
//  Registration.swift
//  ComplexInputScreensHotelManzana
//
//  Created by Minju Lee on 2021/06/26.
//

import Foundation

struct Registration {
    var firtsName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildresn: Int
    
    var rommType: RoomType
    var wifi: Bool
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    //struct안에 들어갈 때는 static 붙여야 함
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
        RoomType(id: 1, name: "One King", shortName: "K", price: 209),
        RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
}
