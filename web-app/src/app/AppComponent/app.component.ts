import {Component} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/retry';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/of';
import {Song} from '../song';
import {User} from '../user';
import {Album} from '../album';
import {Artist} from '../artist';
import {Publisher} from '../publisher';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent {
  readonly ROOT_URL = 'http://192.168.99.100:8080';

  songs: Observable<any>;
  users: Observable<any>;
  albums: Observable<any>;
  artists: Observable<any>;
  publishers: Observable<any>;

  constructor(private http: HttpClient) {
  }

  title = 'Song Search';

  user = {
    id: 'askldfn246245',
  username: 'KhaledAhmed',
  firstname: 'Khaled',
  lastname: 'Ahmed',
  birthdate: '31.12.2000',
  gender: 'male',
  country: 'Germany',
  isAdmin: true
  };

  song = {
    id: '507f191e810c19729de860ea',
    name: 'Legend Has It',
    length: '3:25',
    releaseDate: '2016-12-24',
    lyrics: 'Her what I say, whe are the business today...',
    urls: [],
    genres: ['Hip Hop/Rap'],
    tags: [],
    publisher: '',
    album: 'Run The Jewels 3',
    artists: ['Run The Jewels']
  };

  album = {
    id: '507f191e810c19729de860ea',
    name: 'Run The Jewels 3',
    releaseDate: '2016-12-24',
    genres: ['Hip Hop/Rap'],
    tags: [],
    songs: ['Legend Has It'],
    artists: ['Run The Jewels'],
    publisher: ''
  };

  artist = {
    id: '507f191e810c19729de860ea',
    name: 'Run The Jewels',
    genres: ['Hip Hop/Rap'],
    tags: [],
    songs: ['Legend Has It'],
    publishers: [''],
    albums: ['Run The Jewels 3']
  };

  publisher = {
    id: '507f191e810c19729de860ea',
    name: '',
    genres: ['Hip Hop/Rap'],
    tags: [],
    songs: ['Legend Has It'],
    albums: ['Run The Jewels 3'],
    artists: 'Run The Jewels',
  };

  getSong() {
    // let params = new HttpParams().set('userId', '1');

    this.songs = this.http.get<Song[]>(this.ROOT_URL + '/song');
  }

  getAlbum() {
    this.albums = this.http.get<Album[]>(this.ROOT_URL + '/album');
  }

  getArtist() {
    this.artists = this.http.get<Artist[]>(this.ROOT_URL + '/artist');
  }

  getPublisher() {
    this.publishers = this.http.get<Publisher[]>(this.ROOT_URL + '/publisher');
  }

  getUser() {
    // let params = new HttpParams().set('userId', '1');
    console.log(this.user.username);
    this.users = this.http.get<User[]>(this.ROOT_URL + '/profile');
  }

}
