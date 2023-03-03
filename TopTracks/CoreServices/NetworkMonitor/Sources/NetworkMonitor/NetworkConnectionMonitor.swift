import Network
import Combine

public class NetworkConnectionMonitor: ObservableObject {
  public static var shared = NetworkConnectionMonitor()
  
  private let pathMonitor = NWPathMonitor()
  @Published public private(set) var isNotConnected = false
  @Published private(set) var isExpensive = false
  
  private init() {
    configurePathMonitor()
  }
}

extension NetworkConnectionMonitor {
  private func configurePathMonitor() {
    pathMonitor.pathUpdateHandler = {path in
      DispatchQueue.main.async {
        self.isNotConnected = (path.status == .satisfied) ? false : true
        self.isExpensive = path.isExpensive
      }
    }
    let queue = DispatchQueue(label: "Monitor")
    pathMonitor.start(queue: queue)
  }
}

