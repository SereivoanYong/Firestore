# Firestore

Simplified Firestore Documents  and Decoding

## Firestore Response
```json
{
  "documents": [
    {
      "createTime": "2019-11-26T09:13:39.969797Z",
      "fields": {
        "allowsContactMessages": { "booleanValue": false },
        "iconURL": { "stringValue": "https://res.cloudinary.com/voan/c_scale,w_288/apps/1324887522/icon.png" },
        "identifier": { "stringValue": "1324887522" },
        "index": { "integerValue": "4" },
        "displayName": { "stringValue": "GloryGuide" }
      },
      "name": "projects/xwift27/databases/(default)/documents/apps/1324887522",
      "updateTime": "2019-11-27T06:11:57.268984Z"
    },
    {
      "createTime": "2019-11-23T06:29:31.328113Z",
      "fields": {
        "allowsContactMessages": { "booleanValue": true },
        "identifier": { "stringValue": "1324889421" },
        "index": { "integerValue": "1" },
        "displayName": { "stringValue": "Chuon Nath Dictionary" }
      },
      "name": "projects/xwift27/databases/(default)/documents/apps/1324889421",
      "updateTime": "2019-11-27T06:11:40.956015Z"
    }
  ]
}
```

## FirestoreDocument

`Document` contains all properties but all of them are immutable. Mainly used for `Read` (`Get` and `List`)

```swift
public struct Document<Fields>: DocumentType where Fields: Decodable {
  
  public let name: String
  public let fields: Fields
  public let createTime: Date
  public let updateTime: Date
}
```

`FieldsOnlyDocument` contains only mutable `fields`.  Mainly used for `Write` (`Create` and `Update`)

```swift
public struct FieldsOnlyDocument<Fields>: FieldsOnlyDocumentType where Fields: Decodable {
  
  public var fields: Fields
}
```

## FirestoreError

The `Error` is from Firestore not `Foundation.Error`.
```swift
public struct Error: LocalizedError, Decodable {
  
  public let code: Int
  public let message: String
  public let status: String
}

extension Error {

  /// @see: https://firebase.google.com/docs/reference/swift/firebasefirestore/api/reference/Enums/FirestoreErrorCode
  public enum Code: Int { ... }
}
```

## Usage
- Set up model

  ```swift
  typealias App = Document<AppFields> // or FieldsOnlyDocument<AppFields>

  struct AppFields: Decodable {
    
    var index: IntegerValue
    var identifier: StringValue
    var displayName: StringValue
    var iconURL: URLValue?
    var allowsContactMessages: BooleanValue
  }
  ```
- Access properties of `fields` directly (thank to `@dynamicMemberLookup`)

  ```swift
  typealias App = FieldsOnlyDocument<AppFields>
  var app = App(...)
  app.name
  app.createTime
  app.updateTime
  app.index // Int - equivalent to app.fields.index.integerValue
  app.identifier // String - equivalent to app.fields.identifier.stringValue
  app.iconURL // URL? - equivalent to app.fields.iconURL.urlValue
  app.allowsContactMessages // Bool - equivalent to app.fields.allowsContactMessages.booleanValue

  app.index = 1 // equivalent to app.fields.index.integerValue = 1
  app.iconURL = URL(string: "https://res.cloudinary.com/voan/c_scale,w_288/apps/1324887522/icon.png")
  app.allowsContactMessages = true
  ```

- Create a `JSONDecoder`

  ```swift
  // ISO8601 Date Formatter for Firestore's TimestampValue
  let dateFormatter = DateFormatter()
  dateFormatter.calendar = Calendar(identifier: .iso8601)
  dateFormatter.locale = Locale(identifier: "en_US_POSIX")
  dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"

  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .formatted(dateFormatter)
  ```

- Decode `Get` response data

  ```swift
  let getResult: Result<App, Error> = try decoder.decodeGetResult(from: YOUR_RESPONSE_DATA) 
  switch getResult {
  case .success(let app):
    print(app)
  case .failure(let error):
    print(error)
  }
  ```

- Decode `List` response data:

  ```swift
  let listResult: Result<[App], Error> = try decoder.decodeListResult(from: YOUR_RESPONSE_DATA) 
  switch listResult {
  case .success(let apps):
    print(apps)
  case .failure(let error):
    print(error)
  }
  ```
