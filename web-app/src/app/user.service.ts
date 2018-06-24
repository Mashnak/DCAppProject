import {Injectable} from '@angular/core';
import {Http, URLSearchParams, Response} from '@angular/http';
import {UrlService} from './url.service';

@Injectable()
export class UserService {


  constructor(private http: Http, private urlservice: UrlService) {
  }

  readonly ROOT_URL: string = this.urlservice.getURL();

  registerUser(user) {
    let search = new URLSearchParams();
    search.set('name', user.name);
    search.set('password', user.password);
    user.isAdmin = user.isAdmin.toString();
    search.set('isAdmin', user.isAdmin);
    this.http.post(this.ROOT_URL + '/register', {}, {search}).subscribe(res => console.log(res.json()));
  }

  getUser(loginUser) {
    let search = new URLSearchParams();
    search.set('name', loginUser.name);
    search.set('password', loginUser.password);
    const url = this.ROOT_URL + '/login';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }

  userLogout(user) {
    let search = new URLSearchParams();
    search.set('name', user.name);
    const url = this.ROOT_URL + '/logout';
    return this.http.get(url, {search})
      .map((res: Response) => (res.json()));
  }
}
