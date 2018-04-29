import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {SongsearchComponent} from './songsearch.component';
import {SongitemComponent} from './songitem.component';
import {DetailpageComponent} from './detailpage.component';
import {routing} from './app.routing';
import {HttpClientModule} from '@angular/common/http';

@NgModule({
  declarations: [
    SongsearchComponent, SongitemComponent, DetailpageComponent
  ],
  imports: [
    BrowserModule, routing,  HttpClientModule
  ],
  providers: [],
  bootstrap: [SongsearchComponent]
})
export class AppModule {
}
