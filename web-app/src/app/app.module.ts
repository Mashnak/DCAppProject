import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './AppComponent/app.component';
import {SongitemComponent} from './songitem/songitem.component';
import {DetailpageComponent} from './detailpage/detailpage.component';
import {routing} from './app.routing';
import {HttpClientModule} from '@angular/common/http';
import {AlbumitemComponent} from './albumitem/albumitem.component';
import {ArtistitemComponent} from './artistitem/artistitem.component';
import {PublisheritemComponent} from './publisheritem/publisheritem.component';
import {UseritemComponent} from './useritem/useritem.component';

@NgModule({
  declarations: [

    AppComponent, SongitemComponent, AlbumitemComponent, ArtistitemComponent, PublisheritemComponent, UseritemComponent, DetailpageComponent
  ],
  imports: [
    BrowserModule, routing, HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
