//
//  Value.swift
//
//  Created by Sereivoan Yong on 11/27/19.
//

import Foundation

public protocol ValueType: Codable {
  
  associatedtype Value
  var value: Value { get set }
  init(_ value: Value)
}

public struct BooleanValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "booleanValue"
  }
  
  public var value: Bool
  
  public init(_ value: Bool) {
    self.value = value
  }
}

public struct IntegerValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "integerValue"
  }
  
  public var value: Int
  
  public init(_ value: Int) {
    self.value = value
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.value = try Int(container.decode(String.self, forKey: .value)) ?? 0
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(String(value), forKey: .value)
  }
}

public struct DoubleValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "doubleValue"
  }
  
  public var value: Double
  
  public init(_ value: Double) {
    self.value = value
  }
}

public struct TimestampValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "timestampValue"
  }
  
  public var value: Date
  
  public init(_ value: Date) {
    self.value = value
  }
}

public struct StringValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "stringValue"
  }
  
  public var value: String
  
  public init(_ value: String) {
    self.value = value
  }
}

public struct ReferenceValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "referenceValue"
  }
  
  public var value: String
  
  public init(_ value: String) {
    self.value = value
  }
}

public struct GeoPointValue: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "geoPointValue"
  }
  
  public var value: GeoPoint
  
  public init(_ value: GeoPoint) {
    self.value = value
  }
}

/// Element mixed types not supported yet.
public struct ArrayValue<Value>: ValueType where Value: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "arrayValue"
  }
  
  public var value: [Value]
  
  public init(_ value: [Value]) {
    self.value = value
  }
}

/// Element mixed types not supported yet.
public struct MapValue<Value>: ValueType where Value: ValueType {
  
  private enum CodingKeys: String, CodingKey {
    
    case value = "mapValue"
  }
  
  public var value: [String: Value]
  
  public init(_ value: [String: Value]) {
    self.value = value
  }
}
