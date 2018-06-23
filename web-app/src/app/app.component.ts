import {Component} from '@angular/core';
import {Injectable} from '@angular/core';
import {Observable} from 'rxjs/Observable';

import {Song} from '../song';
import {HttpClient} from '@angular/common/http';

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
  songItems: Observable<any>;


  onSubmit(searchForm) {
    let searchValue = (JSON.stringify(searchForm.searchText));
    searchValue = searchValue.replace(/\"/g, '');
    searchValue = searchValue.replace(/ /g, '_');
    console.log(this.ROOT_URL + '/search?term\=' + searchValue);
    this.songItems = this.httpClient.get(this.ROOT_URL + '/search?term\=' + searchValue);
  }
}
