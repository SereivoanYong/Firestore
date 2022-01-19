//
//  Document.swift
//
//  Created by Sereivoan Yong on 11/27/19.
//

import Foundation

@dynamicMemberLookup
public protocol DocumentType: Decodable {

  associatedtype Fields: Decodable
  var fields: Fields { get }
}

extension DocumentType {

  @inlinable
  public subscript<T>(dynamicMember keyPath: KeyPath<Fields, T>) -> T.Value where T: ValueType {
    return fields[keyPath: keyPath].value
  }

  @inlinable
  public subscript<T>(dynamicMember keyPath: KeyPath<Fields, T?>) -> T.Value? where T: ValueType {
    return fields[keyPath: keyPath]?.value
  }
}

public protocol FieldsOnlyDocumentType: DocumentType, Encodable where Fields: Encodable {

  var fields: Fields { get set }
}

extension FieldsOnlyDocumentType {

  @inlinable
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Fields, T>) -> T.Value where T: ValueType {
    get { return fields[keyPath: keyPath].value }
    set { fields[keyPath: keyPath].value = newValue }
  }

  @inlinable
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Fields, T?>) -> T.Value? where T: ValueType {
    get { return fields[keyPath: keyPath]?.value }
    set { fields[keyPath: keyPath] = newValue.map(T.init) }
  }
}

public struct Document<Fields>: DocumentType where Fields: Decodable {

  public let name: String
  public let fields: Fields
  public let createTime: Date
  public let updateTime: Date
}

public struct FieldsOnlyDocument<Fields>: FieldsOnlyDocumentType where Fields: Codable {

  public var fields: Fields

  public init(fields: Fields) {
    self.fields = fields
  }
}
