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
    },
    {
      id: 2,
      name: 'Testname3',
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
      name: 'Testname4',
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
      name: 'Testname5',
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
      name: 'Testname6',
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
      name: 'Testname7',
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
      name: 'Testname8',
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
      name: 'Testname9',
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
      id: 10,
      name: 'Testname10',
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
      id: 11,
      name: 'Testname11',
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

  getSongs() {
    console.log('Search');
    // http request to get songs!
  }
}
