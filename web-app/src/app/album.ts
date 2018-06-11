export interface Album {
  id: string;
  name: string;
  releaseDate: string;
  genres: Array<string>;
  tags: Array<string>;
  songs: Array<string>;
  artists: Array<string>;
  publisher: string;
}

