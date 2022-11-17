//
//  MyEventsInteractor.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import Foundation

final class MyEventsInteractor {
	weak var output: MyEventsInteractorOutput?
}

extension MyEventsInteractor: MyEventsInteractorInput {
}
