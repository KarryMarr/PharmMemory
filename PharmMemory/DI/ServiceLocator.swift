//
//  ServiceLocator.swift
//  PharmMemory
//
//  Created by Karina Blinova on 21.06.2025.
//

final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services = [String: Any]()
    
    private init() {}
    
    func register<T>(_ service: T, for type: T.Type) {
        let key = String(describing: type)
        services[key] = service
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return services[key] as? T
    }
}
