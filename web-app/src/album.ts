export interface Album {
  id: string;
  name: string;
  totalLength: string;
  releaseDate: string;
  genres: Array<string>;
  songs: Array<string>;
  tags: Array<string>;
  artists: Array<string>;
}
