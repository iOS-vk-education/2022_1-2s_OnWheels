//
//  AddEventInfoCDModel.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import Foundation

struct AddEventInfoCDModel: Hashable {
    let uid: String
    let name: String
    let loction: String
    let dateFrom: String
    let dateTo: String
    let raceDescription: String
    let firstTag: String
    let secondTag: String
}

extension AddEventInfoCDModel {
    init?(from addEventCD: AddEventCDEntity?) {
        self.init(uid: addEventCD?.eventUId ?? "",
                  name: addEventCD?.nameText ?? "",
                  loction: addEventCD?.location ?? "",
                  dateFrom: addEventCD?.dateFrom ?? "",
                  dateTo: addEventCD?.dateTo ?? "",
                  raceDescription: addEventCD?.eventDescription ?? "",
                  firstTag: addEventCD?.firstTag ?? "",
                  secondTag: addEventCD?.secondTag ?? "")
    }
}
