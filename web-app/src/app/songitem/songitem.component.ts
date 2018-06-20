import {Component, Input} from '@angular/core';
import {HttpClient, HttpParams} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {Song} from '../song';

@Component({
  selector: 'app-songitem',
  templateUrl: './songitem.component.html',
  styleUrls: ['./songitem.component.css']
})
export class SongitemComponent {
  readonly ROOT_URL = 'http://192.168.99.100:8080';
  @Input() songitem;


  constructor(private http: HttpClient) {
  }

  addtofavorite() {
    console.log('Test');
    // this.songitem = this.http.post<Song[]>(this.ROOT_URL + '/song', this.songitem); // needs to be formated correct

  }

  onSubmit(songitem) {
    console.log(this.songitem);
    // this.songitem = this.http.post<Song[]>(this.ROOT_URL + '/song', this.songitem);
  }
}
