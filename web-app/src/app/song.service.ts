import { Injectable } from '@angular/core';
import {Http, URLSearchParams, Response} from '@angular/http';

@Injectable()
export class SongService {


  readonly ROOT_URL: string = 'http://192.168.99.100:8080';
  constructor(private http: Http) { }

  getSong(searchResult) {
    let search = new URLSearchParams();
    search.set('name', searchResult.searchText);
    const url = this.ROOT_URL + '/login';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }

  getRandom() {
    let search = new URLSearchParams();
    search.set('count', '10');
    const url = this.ROOT_URL + '/random';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }
}
