import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {AppComponent} from './app.component';
import {HttpClientModule} from '@angular/common/http';
import {FormsModule} from '@angular/forms';
import {SongitemComponent} from './songitem';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import {SongItemListComponent} from './songitemlist';

@NgModule({
  declarations: [
    AppComponent,
    SongitemComponent,
    SongItemListComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    FormsModule,
    NgbModule.forRoot()],
  bootstrap: [AppComponent]
})
export class AppModule {
}
