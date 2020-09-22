//
//  Foundation+Value.swift
//
//  Created by Sereivoan Yong on 11/27/19.
//

import Foundation

/// Backed by string value
public struct URLValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "stringValue"
  }
  
  public var value: URL
  
  public init(_ value: URL) {
    self.value = value
  }
}

public struct RepresentableValue<Representable, Backed>: ValueType where Representable: RawRepresentable & Codable, Backed: ValueType, Representable.RawValue == Backed.Value {
  
  private var backedValue: Backed
  
  public var value: Representable {
    get { return Representable(rawValue: backedValue.value)! }
    set { backedValue.value = newValue.rawValue }          
  }
  
  public init(_ value: Representable) {
    backedValue = Backed(value.rawValue)
  }
  
  public init(with decoder: Decoder) throws {
    backedValue = try Backed(from: decoder)
  }
  
  public func encode(to encoder: Encoder) throws {
    try backedValue.encode(to: encoder)
  }
}
