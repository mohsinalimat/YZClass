//
//  YZURL.swift
//  YZLibraries
//
//  Created by Vipul Patel on 21/04/20.
//

import Foundation
import AVKit

//MARK: - URL Extension(s)
extension URL {
    
    /// It will check file existance for given URL.
    /// - Returns: It will return `Bool` type value.
    public var isFileExists: Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: path)
    }
    
    /// It will generate data object from given file URL.
    /// If there is any issues with URL, it will return `nil`.
    /// - Returns: Provide `Data` type object
    public var convertToData: Data? {
        do {
            return try Data(contentsOf: self)
        }catch let error {
            print(#function + " : " + error.localizedDescription)
        }
        return nil
    }

    /// It will check file existance and delete from given URL.
    public func deleteFile() {
        let fileManager = FileManager.default
        if isFileExists {
            do {
                try fileManager.removeItem(at: self)
            } catch let error as NSError {
                print(#function + " : " + error.localizedDescription)
            }
        }
    }

    /// It will use to get thumbnail image from given video file URL.
    /// If there is any issues with URL, it will return `nil`.
    /// - Returns: Provide `UIImage` from given video file URL.
    public func getThumbnailFromVideo() -> UIImage? {
        let asset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 1)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return  UIImage(cgImage:imageRef)
        } catch let error {
            imageGenerator.cancelAllCGImageGeneration()
            print(#function + " : " + error.localizedDescription)
        }
        return nil
    }
    
    /// It will use to compress video for given URL.
    /// - Parameters:
    ///   - outputURL: Provide output URL to get compress video.
    ///   - handler: Asynchronous handler, which provide compressed video.
    public func compressVideo(_ outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?, _ compressVideoURL: URL?)-> Void) {
        let urlAsset = AVURLAsset(url: self, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
            DispatchQueue.main.async {
                handler(nil, nil)
            }
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            DispatchQueue.main.async {
                handler(exportSession, outputURL)
            }
        }
    }
    
    /// It will use to get value from given query parameter.
    /// - Parameter parameter: Query parameter string to get it's value.
    /// - Returns: It will return value for given query parameter.
    public func getValueForQuery(_ parameter: String) -> String? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems?.first { $0.name == parameter }?.value
    }
}
