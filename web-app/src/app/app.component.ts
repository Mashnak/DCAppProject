import {Component} from '@angular/core';
import {Injectable} from '@angular/core';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {Song} from '../song';
import {HttpClient, HttpResponse} from '@angular/common/http';

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
  songItems: any;

  onSubmit(searchForm) {
    let searchValue = (JSON.stringify(searchForm.searchText));
    searchValue = searchValue.replace(/\"/g, '');
    searchValue = searchValue.replace(/ /g, '_');
    this.songItems = this.httpClient.get(this.ROOT_URL + '/search?term=Stupid Love');
    console.log(this.songItems);
  }

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // return this.http.post<Song>(this.ROOT_URL, songItem);
  }
}
