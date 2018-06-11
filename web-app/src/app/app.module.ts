import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './AppComponent/app.component';
import {routing} from './app.routing';
import {HttpClientModule} from '@angular/common/http';
import {SongitemComponent} from './songitem/songitem.component';
import {AlbumitemComponent} from './albumitem/albumitem.component';
import {ArtistitemComponent} from './artistitem/artistitem.component';
import {PublisheritemComponent} from './publisheritem/publisheritem.component';
import {DetailpageComponent} from './detailpage/detailpage.component';
import {UseritemComponent} from './useritem/useritem.component';

@NgModule({
  declarations: [

    AppComponent,
    SongitemComponent,
    AlbumitemComponent,
    ArtistitemComponent,
    PublisheritemComponent,
    DetailpageComponent,
    UseritemComponent
  ],
  imports: [
    BrowserModule, routing, HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
