# API - Layout

[comment]: <> (Author: Khaled Ahmed)

Client to Business-Logic
Request is forwarded if business logic allows it

- GetSongInfo
  - Request
    - GET /song/fuhdusia374fndj1
  - Response
    - SongJson

- GetAlbumInfo
  - Request
    - GET /album/fdusai327478glgjo
  - Response
    - AlbumJson

- GetArtistInfo
  - Request
    - GET /artist/mbkfdi435jiokfvdafdh
  - Response
    - ArtistJson

- GetPublisherInfo
  - Request
    - GET /publisher/uf8d9sahzr2we2q6q2
  - Response
    - PublisherJson

- GetComments
  - Request
    - Get /type/jhkdsjfheurzwz832729329/comments
  - Response
    - CommentJSON
  - type
    - song
    - album
    - artist

- GetProfile
  - Request
    - Get /profile/username
  - Response
    - ProfileJSON

- GetPlaylist
  - Request
    - GET /playlist/dfdgdfgtrzdfdgdg23f4
  - Response
    - PlaylistJSON

- GetUserSearchResult
  - Request
    - GET /user/search?arg1={0}
  - Response
    - ResultJSON
  - Parameter
    - username

- GetSearchResult
  - Request
    - GET /type/search?arg1={0}&arg2={1}&arg3={2}&arg4={3}
  - Response
    - ResultJSON
  - Args
    - song
    - album
    - artist
    - publisher
  - types
    - song
    - album
    - artist
    - publisher