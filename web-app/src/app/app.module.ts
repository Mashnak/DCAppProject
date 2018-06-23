import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './app.component';
import {Http, Response, RequestOptions, Headers, HttpModule} from '@angular/http';
import {FormsModule} from '@angular/forms';
import {SongitemComponent} from './songitem';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { RegisterComponent } from './register.component';
import { LoginComponent } from './login.component';

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
  bootstrap: [AppComponent]
})
export class AppModule {
}
