//
//  NetworkMonitor.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 16.12.2022.
//

import Foundation
import Network


//class NetworkMonitor {
//    static let shared = NetworkMonitor()
//
//    let monitor = NWPathMonitor()
//    private var status: NWPath.Status = .requiresConnection
//    var isReachable: Bool { status == .satisfied }
//    var isReachableOnCellular: Bool = true
//    public private(set) var isConnected: Bool = false
//
//    func startMonitoring() {
//        monitor.pathUpdateHandler = { [weak self] path in
//            self?.status = path.status
//            self?.isReachableOnCellular = path.isExpensive
//
//            if path.status == .satisfied {
//                print("We're connected!")
//                // post connected notification
//            } else {
//                print("No connection.")
//                // post disconnected notification
//            }
//
////            if path.isExpensive {
////                print("cellular or hotspot")
////            } else {
////                print("WiFi")
////            }
////            print(path.isExpensive)
//        }
//
//        let queue = DispatchQueue(label: "NetworkMonitor")
//        monitor.start(queue: queue)
//    }
//
//    func stopMonitoring() {
//        monitor.cancel()
//    }
//}

//final class NetworkMonitor {
//    static let shared = NetworkMonitor()
//
//    private let queue = DispatchQueue.global()
//    private let monitor: NWPathMonitor
//
//    public private(set) var isConnected: Bool = false {
//        didSet {
//
//            print(isConnected ? "connect" : "disconnect")
//        }
//    }
//
//    public private(set) var connectionType: ConnectionType = .unknown
//
//    enum ConnectionType {
//        case wifi
//        case cellurar
//        case ethernet
//        case unknown
//    }
//
//    private init() {
//        monitor = NWPathMonitor()
//    }
//
//    public func startMonitoring() {
//        monitor.start(queue: queue)
//        monitor.pathUpdateHandler = { [weak self] path in
//
//            self?.queue.asyncAfter(deadline: .now() + 2 ) {
//                print(path.status)
//                self?.isConnected = path.status != .unsatisfied
//                self?.getConnectionType(path)
//            }
//        }
//    }
//
//    public func stopMonitoring() {
//        monitor.cancel()
//    }
//
//    private func getConnectionType(_ path: NWPath) {
//        if path.usesInterfaceType(.wifi) {
//            connectionType = .wifi
//        }
//        else if path.usesInterfaceType(.cellular) {
//            connectionType = .cellurar
//        }
//        else if path.usesInterfaceType(.wiredEthernet) {
//            connectionType = .ethernet
//        }
//        else {
//            connectionType = .unknown
//        }
//    }
//}

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let queue = DispatchQueue(label: "monitor")
    private let monitor: NWPathMonitor
    public private(set) var isConnected: NWPath.Status = .unsatisfied

    init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status
            print(path.status)
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}

