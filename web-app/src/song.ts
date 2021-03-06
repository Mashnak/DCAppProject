import {URL} from './URL';

export interface Song {
  id: string;
  name: string;
  length: string;
  releaseDate: string;
  lyrics: string;
  urls: Array<URL>;
  genres: Array<string>;
  tags: Array<string>;
  album: string;
  artists: Array<string>;
}

