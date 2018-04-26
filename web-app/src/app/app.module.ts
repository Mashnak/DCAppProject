import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {SongsearchComponent} from './songsearch.component';
import {SongitemComponent} from './songitem.component';
import {DetailpageComponent} from './detailpage.component';

@NgModule({
  declarations: [
    SongsearchComponent, SongitemComponent, DetailpageComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [SongsearchComponent]
})
export class AppModule {
}
