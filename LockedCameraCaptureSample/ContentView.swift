//
//  ContentView.swift
//  LockedCameraCaptureSample
//
//  Created by aoyamakai on 2024/09/21.
//

import SwiftUI
import AVFoundation
import LockedCameraCapture

struct ContentView: View {
    
    @State var imageValues: [UIImage] = []
    
    var body: some View {
        VStack {
            Button("LockedCaptureで撮影した写真を表示する") {
                getLockedCaptureImage()
            }
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(imageValues.indices, id: \.self) { index in
                        Image(uiImage: imageValues[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            Task {
                let _ = await AVCaptureDevice.requestAccess(for: .video)
            }
        }
        .padding()
    }
    
    private func getLockedCaptureImage() {
        for url in LockedCameraCaptureManager.shared.sessionContentURLs {
            let fileUrl = url.appendingPathComponent("LockedCapture")
            do {
                let data = try Data(contentsOf: fileUrl)
                guard let uiImage = UIImage(data: data) else { return }
                imageValues.append(uiImage)
            } catch {
                // error handling
            }
        }
    }
}

#Preview {
    ContentView()
}
