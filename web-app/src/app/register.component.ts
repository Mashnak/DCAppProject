import {Component} from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {

  constructor() {
  }

  onSubmit(user) {
    console.log(user.registerUserName);
    console.log(user.registerPassword);
    console.log(user.isAdmin);
    // http post to database /register?name=username&password=password&isAdmin=true
  }
}
