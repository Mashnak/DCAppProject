import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './AppComponent/app.component';
import {SongitemComponent} from './songitem/songitem.component';
import {DetailpageComponent} from './detailpage/detailpage.component';
import {routing} from './app.routing';
import {HttpClientModule} from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent, SongitemComponent, DetailpageComponent
  ],
  imports: [
    BrowserModule, routing,  HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
