//
//  Operators.swift
//  Operadics
//
//  Created by Robert Widmann on 07/07/2015.
//  Copyright (c) 2015 TypeLift. All rights reserved.
//  Released under the MIT License.
//
// Precedence marks for certain symbols aligned with Runes
// ~( https://github.com/thoughtbot/Runes/blob/master/Source/Runes.swift ) until Swift gets a proper
// resolver.

// MARK: Combinators

precedencegroup CompositionPrecedence2 {
	associativity: right
	higherThan: BitwiseShiftPrecedence
}

/// Compose | Applies one function to the result of another function to produce a third function.
infix operator • : CompositionPrecedence2

precedencegroup RightApplyPrecedence2 {
	associativity: right
	higherThan: AssignmentPrecedence
	lowerThan: TernaryPrecedence
}

precedencegroup LeftApplyPrecedence2 {
	associativity: left
	higherThan: AssignmentPrecedence
	lowerThan: TernaryPrecedence
}

/// Apply | Applies an argument to a function.
infix operator § : RightApplyPrecedence2

/// Pipe Backward | Applies the function to its left to an argument on its right.
infix operator <| : RightApplyPrecedence2

/// Pipe forward | Applies an argument on the left to a function on the right.
infix operator |> : LeftApplyPrecedence2

precedencegroup RightAssociativeCombinatorPrecedence2 {
	associativity: right
	lowerThan: DefaultPrecedence
}

precedencegroup LeftAssociativeCombinatorPrecedence2 {
	associativity: left
	lowerThan: DefaultPrecedence
}

/// On | Given a "combining" function and a function that converts arguments to the target of the
/// combiner, returns a function that applies the right hand side to two arguments, then runs both
/// results through the combiner.
infix operator |*| : LeftAssociativeCombinatorPrecedence2

// MARK: Control.*

precedencegroup FunctorPrecedence2 {
	associativity: left
	higherThan: DefaultPrecedence
}

precedencegroup FunctorSequencePrecedence2 {
	associativity: left
	higherThan: FunctorPrecedence2
}

precedencegroup MonadPrecedenceLeft2 {
	associativity: left
	higherThan: FunctorSequencePrecedence2
}

precedencegroup MonadPrecedenceRight2 {
	associativity: right
	higherThan: FunctorSequencePrecedence2
}

/// Fmap | Maps a function over the value encapsulated by a functor.
infix operator <^> : FunctorPrecedence2

/// Replace | Maps all the values encapsulated by a functor to a user-specified constant.
infix operator <^ : FunctorSequencePrecedence2

/// Replace Backwards | Maps all the values encapsulated by a functor to a user-specified constant.
infix operator ^> : FunctorSequencePrecedence2


/// Ap | Applies a function encapsulated by a functor to the value encapsulated by another functor.
infix operator <*> : FunctorPrecedence2

/// Sequence Right | Disregards the Functor on the Left.
///
/// Default definition:
///        `const(id) <^> a <*> b`
infix operator *> : FunctorSequencePrecedence2

/// Sequence Left | Disregards the Functor on the Right.
///
/// Default definition:
///        `const <^> a <*> b`
infix operator <* : FunctorSequencePrecedence2

/// Bind | Sequences and composes two monadic actions by passing the value inside the monad on the
/// left to a function on the right yielding a new monad.
infix operator >>- : MonadPrecedenceLeft2

/// Bind Backwards | Composes two monadic actions by passing the value inside the monad on the
/// right to the funciton on the left.
infix operator -<< : MonadPrecedenceRight2

/// Left-to-Right Kleisli | Composition for monads.
infix operator >>->> : MonadPrecedenceRight2

/// Right-to-Left Kleisli | Composition for monads.
infix operator <<-<< : MonadPrecedenceRight2

/// Extend | Duplicates the surrounding context and computes a value from it while remaining in the
/// original context.
infix operator ->> : MonadPrecedenceLeft2

precedencegroup FunctorExtrasPrecedence2 {
	associativity: left
	higherThan: FunctorSequencePrecedence2
}

/// Imap | Maps covariantly over the index of a right-leaning bifunctor.
infix operator <^^> : FunctorExtrasPrecedence2

/// Contramap | Contravariantly maps a function over the value encapsulated by a functor.
infix operator <!> : FunctorExtrasPrecedence2

// MARK: Data.Result

precedencegroup ResultPrecedence2 {
	associativity: none
	higherThan: FunctorPrecedence2
}

/// From | Creates a Result given a function that can possibly fail with an error.
infix operator !! : ResultPrecedence2

// MARK: Data.Monoid

/// Append | Alias for a Semigroup's operation.
infix operator <> : AdditionPrecedence

// MARK: Control.Category

precedencegroup CategoryPrecedence2 {
	associativity: right
	higherThan: MonadPrecedenceRight2
}

/// Right-to-Left Composition | Composes two categories to form a new category with the source of
/// the second category and the target of the first category.
///
/// This function is literally `•`, but for Categories.
infix operator <<< : CategoryPrecedence2

/// Left-to-Right Composition | Composes two categories to form a new category with the source of
/// the first category and the target of the second category.
///
/// Function composition with the arguments flipped.
infix operator >>> : CategoryPrecedence2

// MARK: Control.Arrow

precedencegroup ArrowPrecedence2 {
	associativity: right
	higherThan: CategoryPrecedence2
}

/// Split | Splits two computations and combines the result into one Arrow yielding a tuple of
/// the result of each side.
infix operator *** : ArrowPrecedence2

/// Fanout | Given two functions with the same source but different targets, this function
/// splits the computation and combines the result of each Arrow into a tuple of the result of
/// each side.
infix operator &&& : ArrowPrecedence2

// MARK: Control.Arrow.Choice

precedencegroup ArrowChoicePrecedence2 {
	associativity: right
	higherThan: ArrowPrecedence2
}

/// Splat | Splits two computations and combines the results into Eithers on the left and right.
infix operator +++ : ArrowChoicePrecedence2

/// Fanin | Given two functions with the same target but different sources, this function splits
/// the input between the two and merges the output.
infix operator ||| : ArrowChoicePrecedence2

// MARK: Control.Arrow.Plus

precedencegroup ArrowPlusPrecedence2 {
	associativity: right
	higherThan: ArrowChoicePrecedence2
}

/// Op | Combines two ArrowZero monoids.
infix operator <+> : ArrowPlusPrecedence2

// MARK: Data.JSON

precedencegroup JSONPrecedence2 {
	associativity: right
	higherThan: ArrowPlusPrecedence2
}

/// Retrieve | Retrieves a value from a dictionary of JSON values using a given keypath.
///
/// If the given keypath is not present or the retrieved value is not of the appropriate type, this
/// function returns `.None`.
infix operator <? : JSONPrecedence2

/// Force Retrieve | Retrieves a value from a dictionary of JSON values using a given keypath,
/// forcing any Optionals it finds.
///
/// If the given keypath is not present or the retrieved value is not of the appropriate type, this
/// function will terminate with a fatal error.  It is recommended that you use Force Retrieve's
/// total cousin `<?` (Retrieve).
infix operator <! : JSONPrecedence2

// MARK: Data.Set

/// Intersection | Returns the intersection of two sets.
infix operator ∩

/// Union | Returns the union of two sets.
infix operator ∪
