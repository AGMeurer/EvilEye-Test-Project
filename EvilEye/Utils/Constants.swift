//
//  Constants.swift
//  EvilEye
//
//  Created by Alexander Meurer on 8/16/23.
//

import Foundation
import SwiftUI

///- Note: UserDefaults Key for AppGroups
let key = "appGroups"

func smallVibration() {
    let impactLight = UIImpactFeedbackGenerator(style: .soft)
    impactLight.impactOccurred()
}

extension View{
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

enum Process: Equatable {
    case notProcessing
    case isProcessing
    case success
    case failed(String)

}

@MainActor
func updateUI(_ action: @escaping () -> Void) async {
    await MainActor.run {
        withAnimation {
            action()
        }
    }
}

func asyncFunction(process: Binding<Process>, errorMsg: String, action: @escaping () async throws -> Void) async {
    Task {
        do {
            await updateUI { process.wrappedValue = .isProcessing }
            try await action()
            await updateUI { process.wrappedValue = .success }
        } catch {
            await updateUI {
                process.wrappedValue = .failed(errorMsg)
            }
        }
    }
}

extension ObservableObject where Self: AnyObject {
    func binding<Value>(for keyPath: ReferenceWritableKeyPath<Self, Value>) -> Binding<Value> {
        return Binding<Value>(
            get: { self[keyPath: keyPath] },
            set: { self[keyPath: keyPath] = $0 }
        )
    }
}
