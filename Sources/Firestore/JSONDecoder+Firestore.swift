//
//  JSONDecoder+Firestore.swift
//
//  Created by Sereivoan Yong on 11/27/19.
//

import Foundation

extension JSONDecoder {
  
  private struct GetResponse<Document>: Decodable where Document: DocumentType {
    
    let document: Document?
    let error: Error?
  }
  
  public func decodeGetResult<Document>(_ documentType: Document.Type, from data: Data) throws -> Result<Document, Error> where Document: DocumentType {
    let decoded = try decode(GetResponse<Document>.self, from: data)
    if let document = decoded.document {
      return .success(document)
    } else if let error = decoded.error {
      return .failure(error)
    } else {
      throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription:  "The `document` and `error` not found."))
    }
  }
  
  public func decodeGetResult<Document>(from data: Data) throws -> Result<Document, Error> where Document: DocumentType {
    return try decodeGetResult(Document.self, from: data)
  }
  
  private struct ListResponse<Document>: Decodable where Document: DocumentType {
    
    let documents: [Document]?
    let error: Error?
  }
  
  public func decodeListResult<Document>(_ documentType: Document.Type, from data: Data) throws -> Result<[Document], Error> where Document: DocumentType {
    let decoded = try decode(ListResponse<Document>.self, from: data)
    if let documents = decoded.documents {
      return .success(documents)
    } else if let error = decoded.error {
      return .failure(error)
    } else {
      throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The `documents` and `error` not found."))
    }
  }
  
  public func decodeListResult<Document>(from data: Data) throws -> Result<[Document], Error> where Document: DocumentType {
    return try decodeListResult(Document.self, from: data)
  }
}
