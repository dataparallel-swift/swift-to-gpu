// Copyright (c) 2025 PassiveLogic, Inc.

// TODO: not sure if this is still necessary as we can hide the Stream as an implementation detail per backend (This means Event below also becomes an implementation detail once we move to an async based function for parallel_for)
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
