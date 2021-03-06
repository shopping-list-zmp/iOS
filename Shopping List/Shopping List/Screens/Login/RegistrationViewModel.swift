//
//  RegistrationViewModel.swift
//  Shopping List
//
//  Created by Mateusz Leśniara on 15/04/2021.
//

import Foundation
import Moya
import RxSwift

protocol RegistrationViewModelProtocol {
    func registerButtonDidTap(registerParameters: RegisterParameters)
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    private weak var coordinator: RegistrationViewControllerCoordinating?
    private let provider = MoyaProvider<AuthApiService>()
    private let disposeBag = DisposeBag()
    
    init(coordinator: RegistrationViewControllerCoordinating) {
        self.coordinator = coordinator
    }
    
    func registerButtonDidTap(registerParameters: RegisterParameters) {
        provider.rx.request(.register(parameters: registerParameters))
            .subscribe { event in
                switch event {
                case let .success(response):
                  print(response.statusCode)
                case let .error(error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
}
