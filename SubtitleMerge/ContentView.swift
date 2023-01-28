//
//  ContentView.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import SwiftUI

// TODO: Make this a generic file picker view of a generic size
struct FileSelectionView: View {
    @Binding var videoInput : URL?
    @Binding var subtitleInput : URL?
    
    var body: some View {
        HStack(spacing: 0) {
            VStack (alignment: .leading, spacing: 15) {
                Text(videoInput?.lastPathComponent ?? "Original Video File")
                Text(subtitleInput?.lastPathComponent ?? "Subtitle File")
            }
            .padding()
            VStack (alignment: .trailing, spacing: 15) {
                FileButton() { filePath in
                    self.videoInput = filePath
                }
                FileButton() { filePath in
                    self.subtitleInput = filePath
                }
            }
            .padding()
        }
    }
}

struct ContentView: View {
    @State var videoInput : URL?
    @State var subtitleInput : URL?
    @State var ffmpegProcess : Process?
    
    var body: some View {
        VStack(spacing: 10) {
            FileSelectionView(videoInput: $videoInput, subtitleInput: $subtitleInput)
            Button("Merge Subtitles", action: mergeSubtitles)
            // TODO: Make this a progress bar
            if ffmpegProcess != nil {
                ProgressView()
            }
            // TODO: done view
        }
        .padding()
    }
    
    func mergeSubtitles() {
        if (ffmpegProcess != nil && ffmpegProcess!.isRunning) {
            return
        }
        
        do {
            let ffmpegProcess = try FFmpegBuilder()
                .inputFile(url: videoInput)
                .subtitleFile(url: subtitleInput)
                .outputFilePath(url: outputPath())
                .build()
            ffmpegProcess.terminationHandler = subtitleMergeCompleted
            
            // TODO: setup pipes to show progress indicator
            try ffmpegProcess.run()
            self.ffmpegProcess = ffmpegProcess
        } catch {
            displayAlert(error)
        }
    }
    
    // TODO: Allow user to choose the output path
    // TODO: Show the output path
    func outputPath() -> URL {
        let outputUrl = URL(fileURLWithPath: videoInput?.path ?? "output")
            .deletingPathExtension()
            .appendingPathExtension("mkv")
    
        return FileManager.default.fileExists(atPath: outputUrl.path)
        ? uniquePath(basePath: outputUrl.deletingPathExtension().path, increment: 1)
        : outputUrl
    }
    
    func uniquePath(basePath: String, increment: Int) -> URL {
        let outputUrl = URL(fileURLWithPath: "\(basePath) (\(increment))")
            .appendingPathExtension("mkv")
        
        if FileManager.default.fileExists(atPath: outputUrl.path) {
            return uniquePath(basePath: basePath, increment: increment + 1)
        }
        
        return FileManager.default.fileExists(atPath: outputUrl.path)
        ? uniquePath(basePath: basePath, increment: increment + 1)
        : outputUrl
    }
    
    func subtitleMergeCompleted(process: Process) {
        self.ffmpegProcess = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
