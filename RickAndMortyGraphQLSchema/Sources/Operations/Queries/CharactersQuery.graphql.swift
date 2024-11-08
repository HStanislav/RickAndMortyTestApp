// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharactersQuery: GraphQLQuery {
  public static let operationName: String = "Characters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Characters($page: Int!, $includePageInfo: Boolean!) { characters(page: $page) { __typename results { __typename id name image status gender } info @include(if: $includePageInfo) { __typename pages } } }"#
    ))

  public var page: Int
  public var includePageInfo: Bool

  public init(
    page: Int,
    includePageInfo: Bool
  ) {
    self.page = page
    self.includePageInfo = includePageInfo
  }

  public var __variables: Variables? { [
    "page": page,
    "includePageInfo": includePageInfo
  ] }

  public struct Data: RickAndMortyGraphQLSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RickAndMortyGraphQLSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("characters", Characters?.self, arguments: ["page": .variable("page")]),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }

    /// Characters
    ///
    /// Parent Type: `Characters`
    public struct Characters: RickAndMortyGraphQLSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RickAndMortyGraphQLSchema.Objects.Characters }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("results", [Result?]?.self),
        .include(if: "includePageInfo", .field("info", Info?.self)),
      ] }

      public var results: [Result?]? { __data["results"] }
      public var info: Info? { __data["info"] }

      /// Characters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: RickAndMortyGraphQLSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RickAndMortyGraphQLSchema.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", RickAndMortyGraphQLSchema.ID?.self),
          .field("name", String?.self),
          .field("image", String?.self),
          .field("status", String?.self),
          .field("gender", String?.self),
        ] }

        /// The id of the character.
        public var id: RickAndMortyGraphQLSchema.ID? { __data["id"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }
        /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
        public var gender: String? { __data["gender"] }
      }

      /// Characters.Info
      ///
      /// Parent Type: `Info`
      public struct Info: RickAndMortyGraphQLSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { RickAndMortyGraphQLSchema.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pages", Int?.self),
        ] }

        /// The amount of pages.
        public var pages: Int? { __data["pages"] }
      }
    }
  }
}
