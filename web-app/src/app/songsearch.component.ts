import {Component} from '@angular/core';

@Component({
  selector: 'app-songsearch',
  templateUrl: './songsearch.component.html',
  styleUrls: ['./songsearch.component.css']
})
export class SongsearchComponent {
  title = 'Song Search Example';

  firstsongitem = {
    number: '507f191e810c19729de860ea',
    title: 'Legend Has It',
    length: '3:25',
    releaseDate: '2016-12-24',
    lyrics: 'Her what I say, whe are the business today...',
    genres: 'Hip Hop/Rap',
    album: 'Run The Jewels 3',
    artist: 'Run The Jewels'
  };

  search() {
    // send get request to business logic;
  }
}
