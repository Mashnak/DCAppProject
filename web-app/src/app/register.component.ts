import { Component } from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent  {

  constructor() { }

onSubmit(username, password, isAdmin){
    console.log(username, password, isAdmin);
    // http post to database /register?name=username&password=password&isAdmin=true
}
}
