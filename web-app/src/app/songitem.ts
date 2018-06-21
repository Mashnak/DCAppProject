import {Component} from '@angular/core';
import {Input} from '@angular/core';
import {Output} from '@angular/core';
import {EventEmitter} from '@angular/core';

@Component({
  selector: 'songitem',
  templateUrl: 'songitem.html',
  styleUrls: ['songitem.css', '../../node_modules/bootstrap/dist/css/bootstrap.min.css']
})

export class SongitemComponent {

  @Input() songItem;
  @Output() addedToFavorites = new EventEmitter();

  postSongToFavorites() {
    this.addedToFavorites.emit(this.songItem);
    console.log('added ' + ' to favorites');
  }

  onSubmit(songTag) {
    console.log(songTag);
  }
}
