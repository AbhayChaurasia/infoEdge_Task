//
//  Infoedge_AssignmentTask_SwiftUIApp.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 16/07/25.
//

 
//import SwiftUI
//import SDWebImageSwiftUI
//
//@main
//struct Infoedge_AssignmentTask_SwiftUIApp: App {
//    let persistenceController = PersistenceController.shared
//
//    // App initialization
//    init() {
//        let downloaderConfig = SDWebImageDownloaderConfig()
//        downloaderConfig.sessionConfiguration = .ephemeral
//        SDWebImageDownloader.shared.config = downloaderConfig
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack {
//                PhoneLoginView()
//            }
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}
import SwiftUI
import SDWebImageSwiftUI

@main
struct Infoedge_AssignmentTask_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        //due to simulator error giving problem while run
        // Create a custom config with .ephemeral session
        let customConfig = SDWebImageDownloaderConfig()
        customConfig.sessionConfiguration = URLSessionConfiguration.ephemeral
        
        // Replace default shared downloader with a custom one
        let customDownloader = SDWebImageDownloader(config: customConfig)
        SDWebImageManager.defaultImageLoader = customDownloader
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PhoneLoginView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
