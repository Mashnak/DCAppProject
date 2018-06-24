import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './app.component';
import {HttpModule} from '@angular/http';
import {FormsModule} from '@angular/forms';
import {SongitemComponent} from './songitem';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { RegisterComponent } from './register.component';
import { LoginComponent } from './login.component';
import {UserService} from './user.service';
import {SongService} from './song.service';

@NgModule({
  declarations: [
    AppComponent,
    SongitemComponent,
    RegisterComponent,
    LoginComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    NgbModule.forRoot()],
  providers: [UserService, SongService],
  bootstrap: [AppComponent]
})
export class AppModule {
}
