import {Song} from './song';
import {Album} from './album';
import {Artist} from './artist';

export interface Result {
  song: Song;
  album: Album;
  artist: Artist;
}
