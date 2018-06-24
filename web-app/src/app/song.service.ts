import {Injectable} from '@angular/core';
import {Http, URLSearchParams, Response} from '@angular/http';
import {UrlService} from './url.service';

@Injectable()
export class SongService {


  constructor(private http: Http, private urlservice: UrlService) {
  }

  readonly ROOT_URL: string = this.urlservice.getURL();

  getSong(searchResult) {
    let search = new URLSearchParams();
    search.set('term', searchResult.searchText);
    const url = this.ROOT_URL + '/search';
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
