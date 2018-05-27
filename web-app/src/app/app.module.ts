import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {SongsearchComponent} from './songsearch/songsearch.component';
import {SongitemComponent} from './songitem.component';
import {DetailpageComponent} from './detailpage/detailpage.component';
import {routing} from './app.routing';
import {HttpClientModule} from '@angular/common/http';
import {NavbarComponent} from './navbar/navbar.component';
import {LoginComponent} from './login/login.component';

@NgModule({
  declarations: [
    SongsearchComponent, SongitemComponent, DetailpageComponent, NavbarComponent, LoginComponent
  ],
  imports: [
    BrowserModule, routing,  HttpClientModule
  ],
  providers: [],
  bootstrap: [SongsearchComponent]
})
export class AppModule {
}
