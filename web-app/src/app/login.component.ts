import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {

  constructor() { }

  onSubmit(username, password) {
    console.log(username, password);
    // http get with username and password /login?name=username&password=password
  }

}
