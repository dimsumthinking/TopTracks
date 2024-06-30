import Observation
import CoreData


@Observable
public class CloudActivity {
  @MainActor
  public static var isDownloading = false
  private var task: Task<Void, Never>?
  
  init() {
    task = Task {
      for await event in NotificationCenter.default
        .notifications(named: NSPersistentCloudKitContainer.eventChangedNotification)
        .compactMap(\.userInfo)
        .compactMap({ userInfo in
          userInfo[NSPersistentCloudKitContainer.eventNotificationUserInfoKey]
          as? NSPersistentCloudKitContainer.Event}) {
        if Task.isCancelled {break}
        if event.type == .setup || event.type == .import {
          let isDownloading = !event.succeeded
          Task { @MainActor in
            CloudActivity.isDownloading = isDownloading
          }
        }
      }
    }
  }
  deinit {
    task?.cancel()
  }
  
  
}

