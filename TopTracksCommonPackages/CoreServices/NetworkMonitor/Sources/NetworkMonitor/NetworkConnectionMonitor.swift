import Network
import Observation

@Observable
public class NetworkConnectionMonitor {
  public static var shared = NetworkConnectionMonitor()
  
  private let pathMonitor = NWPathMonitor()
  public private(set) var isNotConnected = false
  private(set) var isExpensive = false
  
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
