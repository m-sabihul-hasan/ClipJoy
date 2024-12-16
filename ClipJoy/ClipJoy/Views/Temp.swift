
//
//import SwiftUI
//import AVKit
//import Foundation
//
//struct Reel: Identifiable {
//    let id = UUID()
//    let videoURL: URL
//    let caption: String
//    let username: String
//}
//
//class ReelsViewModel: ObservableObject {
//    @Published var reels: [Reel] = []
//
//    func addReel(_ reel: Reel) {
//        reels.insert(reel, at: 0)
//    }
//}
//
//struct ReelPlayerView: View {
//    let reel: Reel
//    @State private var player: AVPlayer?
//
//    var body: some View {
//        ZStack {
//            if let player = player {
//                VideoPlayer(player: player)
//                    .onAppear {
//                        player.play()
//                        player.actionAtItemEnd = .none
//                        NotificationCenter.default.addObserver(
//                            forName: .AVPlayerItemDidPlayToEndTime,
//                            object: player.currentItem,
//                            queue: .main
//                        ) { _ in
//                            player.seek(to: .zero)
//                            player.play()
//                        }
//                    }
//                    .onDisappear {
//                        player.pause()
//                    }
//            } else {
//                Color.black
//            }
//
//            VStack {
//                Spacer()
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(reel.username)
//                            .font(.headline)
//                            .foregroundColor(.white)
//
//                        Text(reel.caption)
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }
//                    Spacer()
//                }
//                .padding()
//            }
//        }
//        .onAppear {
//            player = AVPlayer(url: reel.videoURL)
//        }
//        .onDisappear {
//            player = nil
//        }
//        .ignoresSafeArea()
//    }
//}
//
//struct ReelsFeedView: View {
//    @StateObject private var viewModel = ReelsViewModel()
//    @State private var isPickerPresented = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                TabView {
//                    ForEach(viewModel.reels) { reel in
//                        ReelPlayerView(reel: reel)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//
//                VStack {
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            isPickerPresented = true
//                        }) {
//                            Image(systemName: "plus")
//                                .font(.system(size: 30))
//                                .foregroundColor(.white)
////                                .shadow(radius: 10)
//                                .padding()
//                        }
//                    }
//                    Spacer()
//                }
//            }
//            .background(Color.black)
//            .navigationBarHidden(true)
//            .sheet(isPresented: $isPickerPresented) {
//                VideoPickerView { selectedURL in
//                    if let url = selectedURL {
//                        let newReel = Reel(videoURL: url, caption: "New Reel", username: "@just.sabih")
//                        viewModel.addReel(newReel)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct VideoPickerView: UIViewControllerRepresentable {
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: VideoPickerView
//
//        init(parent: VideoPickerView) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let url = info[.mediaURL] as? URL {
//                parent.completion(url)
//            } else {
//                parent.completion(nil)
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.completion(nil)
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    @Environment(\.presentationMode) private var presentationMode
//    var completion: (URL?) -> Void
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .photoLibrary // Use the Photos library
//        picker.mediaTypes = ["public.movie"] // Restrict to video files
//        picker.videoQuality = .typeMedium
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
