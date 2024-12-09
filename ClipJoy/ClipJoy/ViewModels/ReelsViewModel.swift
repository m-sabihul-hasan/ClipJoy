//
//  ReelsViewModel.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import Foundation
import SwiftUI

class ReelsViewModel: ObservableObject {
    @Published var reels: [Reel] = []

    func addReel(_ reel: Reel) {
        reels.insert(reel, at: 0)
    }
}
