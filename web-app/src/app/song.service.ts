import {Injectable} from '@angular/core';
import {Http, URLSearchParams, Response} from '@angular/http';
import {UrlService} from './url.service';
import {LoginComponent} from './login.component';

@Injectable()
export class SongService {


  constructor(private http: Http, private urlservice: UrlService) {
  }

  readonly ROOT_URL: string = this.urlservice.getURL();

  /**
   * Forwards the searchterm to the Business Logic which returns the songs
   * @param searchResult
   * @returns {Observable<any>}
   */
  getSong(searchResult) {
    let search = new URLSearchParams();
    search.set('term', searchResult.searchText);
    const url = this.ROOT_URL + '/webSearch';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }

  /**
   * Requests all songs for the Business Logic that are stored in the database
   * @returns {Observable<any>}
   */
  getRandom() {
    let search = new URLSearchParams();
    search.set('count', '10');
    const url = this.ROOT_URL + '/random';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }

  /**
   * Forwards the song object to the Business Logic which adds it to the users favoritelist
   * @param song
   */
  postSongToFavorites(song) {
  }

  /**
   * Forwards the song object and the tag to the Business Logic which adds the tag to the specific song
   * @param song
   * @param tag
   */
  postTag(song, tag) {
    let search = new URLSearchParams();
    search.set('name', song);
    search.set('tag', tag);
    const url = this.ROOT_URL + '/tag/song';
    this.http.post(url, {}, {search}).subscribe(res => console.log(res.json()));
  }
}
