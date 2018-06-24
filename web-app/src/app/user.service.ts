import { Injectable } from '@angular/core';
import {Http, URLSearchParams, Response} from '@angular/http';

@Injectable()
export class UserService {


  readonly ROOT_URL: string = 'http://192.168.99.100:8080';
  constructor(private http: Http) { }

  getUser(loginUser) {
    let search = new URLSearchParams();
    search.set('name', loginUser.name);
    search.set('password', loginUser.password);
    const url = this.ROOT_URL + '/login';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }
}
