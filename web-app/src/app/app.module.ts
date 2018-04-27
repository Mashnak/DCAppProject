import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {SongsearchComponent} from './songsearch.component';
import {SongitemComponent} from './songitem.component';
import {DetailpageComponent} from './detailpage.component';
import {routing} from './app.routing';

@NgModule({
  declarations: [
    SongsearchComponent, SongitemComponent, DetailpageComponent
  ],
  imports: [
    BrowserModule, routing
  ],
  providers: [],
  bootstrap: [SongsearchComponent] // Html entry point after index.html
})
export class AppModule {
}
