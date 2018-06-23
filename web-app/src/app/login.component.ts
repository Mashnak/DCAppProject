import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {

  constructor() { }

  onSubmit(loginUser) {
    console.log(loginUser.loginUserName);
    console.log(loginUser.loginPassword);
    // http get with username and password /login?name=username&password=password
  }

}
