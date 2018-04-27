import {Component} from '@angular/core';

@Component({
  selector: 'app-songsearch',
  templateUrl: './songsearch.component.html',
  styleUrls: ['./songsearch.component.css']
})
export class SongsearchComponent {
  title = 'Song Search Example';

  firstsongitem = {
    id: 1,
    title: 'Gangnamstyle',
    artist: 'Psy'
  };
  secondsongitem = {
    id: 2,
    title: 'Highway to hell',
    artist: 'AC/DC'
  };

  search() {
    // send get request to business logic;
  }
}
