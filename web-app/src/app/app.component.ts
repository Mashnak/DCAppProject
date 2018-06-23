import {Component} from '@angular/core';
import {Injectable} from '@angular/core';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {Result} from '../Result';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

@Injectable()
export class AppComponent {
  title = 'Song Search';

  constructor(private httpClient: HttpClient) {
  }

  readonly ROOT_URL = 'http://192.168.99.100:8080';
  songItem: any;

  onSubmit(searchForm) {
    let searchValue = (JSON.stringify(searchForm.searchText));
    searchValue = searchValue.replace(/\"/g, '');
    searchValue = searchValue.replace(/ /g, '_');
    this.songItem = this.httpClient.get(this.ROOT_URL + '/search?term=' + searchValue);
    console.log(typeof this.songItem, this.songItem, this.ROOT_URL + '/search?term=' + searchValue );
  }

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // return this.http.post<Song>(this.ROOT_URL, songItem);
  }
}
