import {Component} from '@angular/core';
import {Http, Response, RequestOptions, Headers, HttpModule, URLSearchParams} from '@angular/http';
import 'rxjs/add/operator/map';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  readonly ROOT_URL: string = 'http://192.168.99.100:8080';

  constructor(private http: Http) {
  }

  onSubmit(loginUser) {
    const url = this.ROOT_URL + '/login';
    let search = new URLSearchParams();
    search.set('name', loginUser.name);
    search.set('name', loginUser.password);
    this.http.get(url, {search}).subscribe(res => console.log(res.json()));
  }

}
