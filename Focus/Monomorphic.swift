//
//  Monomorphic.swift
//  Focus
//
//  Created by Robert Widmann on 8/23/15.
//  Copyright © 2015 SypeLift. All rights reserved.
//

public struct MonomorphicLens<S, A> : LensType {
	public typealias Source = S
	public typealias Target = A
	public typealias AltSource = S
	public typealias AltTarget = A
	
	/// Gets the Indexed Costate Comonad Coalgebroid underlying the receiver.
	private let _run : S -> IxStore<A, A, S>
	
	public func run(v : S) -> IxStore<A, A, S> {
		return _run(v)
	}
	
	/// Produces a lens from an Indexed Costate Comonad Coalgebroid.
	public init(_ f : S -> IxStore<A, A, S>) {
		_run = f
	}
	
	/// Creates a lens from a getter/setter pair.
	public init(get : S -> A, set : (S, A) -> S) {
		self.init({ v in IxStore(get(v)) { set(v, $0) } })
	}
	
	/// Creates a lens that transforms set values by a given function before they are returned.
	public init(get : S -> A, modify : (S, A -> A) -> S) {
		self.init(get: get, set: { v, x in modify(v) { _ in x } })
	}
}

extension MonomorphicLens {
	public init<Other : LensType where
		S == Other.Source, A == Other.Target, S == Other.AltSource, A == Other.AltTarget>
		(_ other : Other)
	{
		self.init(other.run)
	}
}


