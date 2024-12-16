//
//  ContentView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import SwiftUI
import AVKit

struct ReelsFeedView: View {
    @StateObject private var viewModel = ReelsViewModel()
    @State private var isPickerPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    ForEach(viewModel.reels) { reel in
                        ReelPlayerView(reel: reel)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPickerPresented = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
//                                .shadow(radius: 10)
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
            .background(Color.black)
            .navigationBarHidden(true)
            .sheet(isPresented: $isPickerPresented) {
                VideoPickerView { selectedURL in
                    if let url = selectedURL {
                        let newReel = Reel(videoURL: url, caption: "New Reel", username: "@just.sabih")
                        viewModel.addReel(newReel)
                    }
                }
            }
        }
    }
}

#Preview {
    ReelsFeedView()
}
