// Copyright (c) 2025 PassiveLogic, Inc.

public protocol BackendProtocol {
    associatedtype Context: ContextProtocol
    associatedtype Stream: StreamProtocol
}

public protocol StreamProtocol {
    associatedtype Event: EventProtocol
    associatedtype E: Error
    
    static var defaultStream: Self { get }

    func sync() throws(E)
    func record() throws(E) -> Event
    func waitOn(event: Event) throws(E)
}

public protocol ContextProtocol {
    associatedtype E: Error

    func push() throws(E)
    func pop() throws(E)
    func destroy() throws(E)
}

public protocol EventProtocol {
    associatedtype E: Error

    func sync() throws(E)
    func complete() throws(E) -> Bool
}
