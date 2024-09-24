//
//  ContentView.swift
//  LockedCameraCaptureSample
//
//  Created by aoyamakai on 2024/09/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                let _ = await AVCaptureDevice.requestAccess(for: .video)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
