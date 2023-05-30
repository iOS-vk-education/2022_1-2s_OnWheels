//
//  AddEventInfoCDModel.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import Foundation

struct AddEventInfoCDModel: Hashable {
    let name: String
    let loction: String
    let dateFrom: String
    let dateTo: String
    let raceDescription: String
    let imageData: Data?
    let firstTag: String
    let secondTag: String
}

extension AddEventInfoCDModel {
    init?(from addEventCD: AddEventCDEntity?) {
        self.init(name: addEventCD?.nameText ?? "",
                  loction: addEventCD?.location ?? "",
                  dateFrom: addEventCD?.dateFrom ?? "",
                  dateTo: addEventCD?.dateTo ?? "",
                  raceDescription: addEventCD?.eventDescription ?? "",
                  imageData: addEventCD?.eventImage,
                  firstTag: addEventCD?.firstTag ?? "",
                  secondTag: addEventCD?.secondTag ?? "")
    }
}
