import {Component} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {Song} from './song';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/retry';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/of';

@Component({
  selector: 'app-songsearch',
  templateUrl: './songsearch.component.html',
  styleUrls: ['./songsearch.component.css']
})

export class SongsearchComponent {
  readonly ROOT_URL = 'https://jsonplaceholder.typicode.com'; //Fix the ROOT_URL to the correct springboot URL then get and post should work

  posts: Observable<any>;
  newSong: Observable<any>;

  constructor(private http: HttpClient) {
  }

  title = 'Song Search Example';

  getSong() {
    let params = new HttpParams().set('userId', '1');

    this.posts = this.http.get<Song[]>(this.ROOT_URL + '/posts', {params});
  }

  postSong() {
    const data: Song = {
      number: '507f191e810c19729de860ea',
      title: 'Legend Has It',
      length: '3:25',
      releaseDate: '2016-12-24',
      lyrics: 'Her what I say, whe are the business today...',
      genres: 'Hip Hop/Rap',
      album: 'Run The Jewels 3',
      artist: 'Run The Jewels'
    };
    this.newSong = this.http.post(this.ROOT_URL + 'posts', data)
      .retry(3)
      .catch(err => {
        console.log(err);
        return Observable.of(err);
      });
  }
}
