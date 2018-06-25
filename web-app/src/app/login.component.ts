import {Component, EventEmitter, Output} from '@angular/core';
import {Http, Response} from '@angular/http';
import 'rxjs/add/operator/map';
import {User} from '../user';
import {Observable} from 'rxjs/Observable';
import {UserService} from './user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  userResult: Observable<User>;

  constructor(private http: Http, private userservice: UserService) {
    this.userResult = null;
  }

  @Output() userAddedToFavorites = new EventEmitter();

  onSubmit(loginUser) {
    this.userservice.getUser(loginUser).subscribe(data => {
      this.userResult = data;
    });
  }

  userLogout() {
    this.userservice.userLogout(this.userResult).subscribe((res: Response) => console.log());
    this.userResult = null;
  }
}
