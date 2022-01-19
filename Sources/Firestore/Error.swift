//
//  Error.swift
//
//  Created by Sereivoan Yong on 11/27/19.
//

import Foundation

public struct Error: LocalizedError, Decodable {

  public let code: Int
  public let message: String
  public let status: String

  public var code_: Code? {
    return Code(rawValue: code)
  }

  public var errorDescription: String? {
    return message
  }
}

extension Error {

  /// @see: https://firebase.google.com/docs/reference/swift/firebasefirestore/api/reference/Enums/FirestoreErrorCode
  public enum Code: Int {

    /// The operation completed successfully. NSError objects will never have a code with this value.
    case ok = 0

    /// The operation was cancelled (typically by the caller).
    case cancelled = 1

    /// Unknown error or an error from a different error domain.
    case unknown = 2

    /// Client specified an invalid argument. Note that this differs from FailedPrecondition. InvalidArgument indicates arguments that are problematic regardless of the state of the system (e.g., an invalid field name).
    case invalidArgument = 3

    /// Deadline expired before operation could complete. For operations that change the state of the system, this error may be returned even if the operation has completed successfully. For example, a successful response from a server could have been delayed long enough for the deadline to expire.
    case deadlineExceeded = 4

    /// Some requested document was not found.
    case notFound = 5

    /// Some document that we attempted to create already exists.
    case alreadyExists = 6

    /// The caller does not have permission to execute the specified operation.
    case permissionDenied = 7

    /// Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.
    case resourceExhausted = 8

    /// Operation was rejected because the system is not in a state required for the operation’s execution.
    case failedPrecondition = 9

    /// The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.
    case aborted = 10

    /// Operation was attempted past the valid range.
    case outOfRange = 11

    /// Operation is not implemented or not supported/enabled.
    case unimplemented = 12

    /// Internal errors. Means some invariants expected by underlying system has been broken. If you see one of these errors, something is very broken.
    case `internal` = 13

    /// The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.
    case unavailable = 14

    /// Unrecoverable data loss or corruption.
    case dataLoss = 15

    /// The request does not have valid authentication credentials for the operation.
    case unauthenticated = 16
  }
}
