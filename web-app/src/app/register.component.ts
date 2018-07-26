import {Component} from '@angular/core';
import {Http} from '@angular/http';
import 'rxjs/add/operator/map';
import {UserService} from './user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {

  constructor(private http: Http, private userservice: UserService) {
  }

  /**
   * Calls the service function that registers the new user
   * @param user
   */
  onSubmit(user) {
    this.userservice.registerUser(user);
  }
}
