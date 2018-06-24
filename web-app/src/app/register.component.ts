import {Component} from '@angular/core';
import {Http, Response, RequestOptions, Headers, HttpModule, URLSearchParams} from '@angular/http';
import 'rxjs/add/operator/map';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {

  constructor(private http: Http) {
  }

  readonly ROOT_URL: string = 'http://192.168.99.100:8080';

  onSubmit(user) {
    let search = new URLSearchParams();
    search.set('name', user.name);
    search.set('password', user.password);
    user.isAdmin = user.isAdmin.toString();
    search.set('isAdmin', user.isAdmin);
    this.http.post(this.ROOT_URL + '/register', {}, {search}).subscribe(res => console.log(res.json()));
  }
}
