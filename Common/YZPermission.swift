//
//  YZPermission.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit
import Photos
import AVKit
import CoreLocation


//MARK: - Class YZPermission
//It is used to check permissions like camera access, photo library access etc...
public class YZPermission: NSObject {

    public static var checkOrRequest: YZPermission = YZPermission()
    public typealias PermissionStatus = (_ status: Int, _ isGranted: Bool) -> ()
    
    override init() {
        super.init()
    }
}

//MARK: YZPermission Extension(s)
public extension YZPermission {
    
    /// It is used to check camera access permission.
    /// - Parameter block: Asynchronous block execute based on user action
    func cameraAccess(permissionWithStatus block: @escaping PermissionStatus) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    block(AVAuthorizationStatus.authorized.rawValue, true)
                }
            case .denied:
                DispatchQueue.main.async {block(AVAuthorizationStatus.denied.rawValue, false)}
            case .restricted:
                DispatchQueue.main.async {block(AVAuthorizationStatus.restricted.rawValue, false)}
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (grant) in
                    if grant {
                        DispatchQueue.main.async {block(AVAuthorizationStatus.authorized.rawValue, grant)}
                    }else{
                        DispatchQueue.main.async {block(AVAuthorizationStatus.denied.rawValue, grant)}
                    }
                })
            @unknown default:
                fatalError("SOMETHING WRONG.")
            }
        }else{
            DispatchQueue.main.async {block(AVAuthorizationStatus.restricted.rawValue, false)}
        }
    }
    
    /// It is used to check photo library access permission.
    /// - Parameter block: Asynchronous block execute based on user action
    func photoLibraryAccess(permissionWithStatus block: @escaping PermissionStatus) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                DispatchQueue.main.async {block(PHAuthorizationStatus.authorized.rawValue, true)}
            case .denied:
                DispatchQueue.main.async {block(PHAuthorizationStatus.denied.rawValue, false)}
            case .restricted:
                DispatchQueue.main.async {block(PHAuthorizationStatus.restricted.rawValue, false)}
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (grant) in
                    switch grant {
                    case .authorized:
                        DispatchQueue.main.async {block(PHAuthorizationStatus.authorized.rawValue, true)}
                    default:
                        DispatchQueue.main.async {block(PHAuthorizationStatus.denied.rawValue, false)}
                    }
                })
            @unknown default:
                fatalError("SOMETHING WRONG.")
            }
        }else{
            DispatchQueue.main.async {block(PHAuthorizationStatus.restricted.rawValue, false)}
        }
    }
    
    /// It is used to check location access permission.
    /// - Parameter block: Asynchronous block execute based on user action
    func locationAccess(permissionWithStatus block: @escaping PermissionStatus) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways :
            DispatchQueue.main.async {block(Int(CLAuthorizationStatus.authorizedAlways.rawValue), true)}
        case .authorizedWhenInUse :
            DispatchQueue.main.async {block(Int(CLAuthorizationStatus.authorizedWhenInUse.rawValue), true)}
        case .denied :
            DispatchQueue.main.async {block(Int(CLAuthorizationStatus.denied.rawValue), false)}
        case .restricted :
            DispatchQueue.main.async {block(Int(CLAuthorizationStatus.restricted.rawValue), false)}
        case .notDetermined :
            DispatchQueue.main.async {block(Int(CLAuthorizationStatus.notDetermined.rawValue), false)}
        @unknown default:
            fatalError("SOMETHING WRONG.")
        }
    }
}
