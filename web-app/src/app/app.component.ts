import {Component} from '@angular/core';


@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent {
  title = 'Song Search';

  songItems = [{
    id: 1,
    name: 'Testname1',
    length: '3:50',
    releaseDate: '14-5-1992',
    lyrics: '',
    URLs: [''],
    genres: [''],
    tags: ['test1', 'test2'],
    publisher: 'Testpublisher',
    album: 'Testalbum',
    artists: ['Testartist1']
  },
    {
      id: 2,
      name: 'Testname2',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: '',
      URLs: [''],
      genres: [''],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1']
    }
  ];

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // Add the post method to the BL!!!!
  }

}
