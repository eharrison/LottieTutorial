//
//  DownloadViewController.swift
//  LottieTutorialTest
//
//  Created by Evandro Harrison Hoffmann on 14/05/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import UIKit
import Lottie

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var progressView: LottieAnimationView!
    @IBOutlet weak var progressStatusLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    enum ProgressKeyFrames: CGFloat {
        case start = 140
        case end = 187
        case complete = 240
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressStatusLabel.text = "Tap to start"
        progressView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Animation
    
    @IBAction func startProgress(_ sender: Any) {
        downloadButton.isEnabled = false
        progressStatusLabel.text = "Starting download..."
        progressView.play(fromFrame: 0, toFrame: ProgressKeyFrames.start.rawValue, loopMode: .none) { [weak self] (_) in
            self?.download()
        }
    }
    
    // sets download progress
    private func progress(to progress: CGFloat) {
      // 1. We get the range of frames specific for the progress from 0-100%
      let progressRange = ProgressKeyFrames.end.rawValue - ProgressKeyFrames.start.rawValue
      // 2. Then, we get the exact frame for the current progress
      let progressFrame = progressRange * progress
      // 3. Then we add the start frame to the progress frame
      // Considering the example that we start in 140, and we moved 30 frames in the progress, we should show frame 170 (140+30)
      let currentFrame = progressFrame + ProgressKeyFrames.start.rawValue
      // 4. Manually setting the current animation frame
      progressView?.currentFrame = currentFrame
      print("Downloading \((progress*100).rounded())%")
    }
    
    private func startDownload() {
        progressView.play(fromFrame: ProgressKeyFrames.start.rawValue, toFrame: ProgressKeyFrames.end.rawValue, loopMode: .none) { [weak self] (_) in
            self?.endDownload()
        }
    }
    
    private func endDownload() {
        downloadButton.isEnabled = true
        progressStatusLabel.text = "Download finished"
        progressView.play(fromFrame: ProgressKeyFrames.end.rawValue, toFrame: ProgressKeyFrames.complete.rawValue, loopMode: .none)
    }
}

extension DownloadViewController: URLSessionDownloadDelegate {
    private func download() {
        let url = URL(string: "https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4")!
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentDownloaded: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.progress(to: percentDownloaded)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.endDownload()
        }
    }
}
