//
//  LoginViewModel.swift
//  
//
//  Created by Nima Salehi on 11/7/25.
//

import Foundation
import Combine
import Core

@MainActor
public final class LoginViewModel: ObservableObject {
    @Published public var username = ""    /*01*/
    @Published public var password = ""    /*02*/
    @Published public var isLoading = false /*03*/
    @Published public var errorMessage: String? = nil /*04*/

    private var cancellables = Set<AnyCancellable>() /*05*/

    public init() {} /*06*/

    // MARK: - Combine version for Xcode 14
    public func loginPublisher() -> AnyPublisher<Bool, Never> { /*07*/
        isLoading = true
        return Just(true)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in self.isLoading = false })
            .eraseToAnyPublisher()
    }

    // MARK: - async/await (supported in Xcode 14)
    public func loginAsync() async -> Bool { /*08*/
        isLoading = true
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) /*09*/
        } catch {
            print("Sleep interrupted")
        }
        isLoading = false
        return username == "admin" && password == "1234" /*10*/
    }
}

/*
📘 English:
- Compatible with Xcode 14 & Swift 5.7
- Uses Combine and async/await safely
📗 فارسی:
- نسخه سازگار با Xcode 14
- از async/await و Combine هر دو پشتیبانی می‌کند
✅ Breakpoints:
- خط (08): شروع لاگین async
- خط (10): بررسی نتیجه ورود
*/
