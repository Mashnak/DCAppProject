import {Component} from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-songsearch',
  templateUrl: './songsearch.component.html',
  styleUrls: ['./songsearch.component.css']
})

export class SongsearchComponent {
  readonly ROOT_URL = 'https://jsonplaceholder.typicode.com';

  posts: any;

  constructor(private http: HttpClient) {
  }

  title = 'Song Search Example';

  getPosts() {
    this.posts = this.http.get(this.ROOT_URL + '/posts');
  }
}
