import {Component} from '@angular/core';
import {Input} from '@angular/core';
import {Output} from '@angular/core';
import {EventEmitter} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {Injectable} from '@angular/core';
import {Observable} from 'rxjs/Observable';
import {Song} from '../song';

@Component({
  selector: 'songitem',
  templateUrl: 'songitem.html',
  styleUrls: ['songitem.css', '../../node_modules/bootstrap/dist/css/bootstrap.min.css']
})

@Injectable()
export class SongitemComponent {

  constructor(private http: HttpClient) {
  }
  readonly ROOT_URL = 'http://192.168.99.100:8080';
  Songs: Observable<any>;

  @Input() songItem;
  @Output() addedToFavorites = new EventEmitter();

  postSongToFavorites() {
    this.addedToFavorites.emit(this.songItem);
    console.log('added ' + ' to favorites');
  }

  onSubmit(songTag) {
    console.log(songTag);
    return this.http.post<Song>(this.ROOT_URL, songTag);
  }
}
