export interface Song {
  id: string;
  name: string;
  length: string;
  releaseDate: string;
  lyrics: string;
  urls: Array<string>;
  genres: Array<string>;
  tags: Array<string>;
  publisher: string;
  album: string;
  artists: Array<string>;
}

