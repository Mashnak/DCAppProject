import {Component, Input, Output, EventEmitter} from '@angular/core';
import {Http} from '@angular/http';
import {Injectable} from '@angular/core';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {SongService} from './song.service';

@Component({
  selector: 'app-songitem',
  templateUrl: 'songitem.html',
  styleUrls: ['songitem.css', '../../node_modules/bootstrap/dist/css/bootstrap.min.css']
})

@Injectable()
export class SongitemComponent {
  closeResult: string;

  constructor(private http: Http, private modalService: NgbModal, private songservice: SongService) {
  }

  @Input() searchResult;
  @Output() addedToFavorites = new EventEmitter();

  /**
   * Sends the song to appcomponent.postSongToFavorite to add the song to the users favoritelist
   */
  postSongToFavorites() {
    this.addedToFavorites.emit(this.searchResult);
  }

  /**
   * Calls the service function that adds the tag to the specific song
   * @param song
   * @param tag
   */
  onSubmit(song, tag) {
    this.songservice.postTag(song, tag.tags);
  }

  /**
   * Opens the popup to show tho songs lyrics
   * @param content
   */
  open(content) {
    this.modalService.open(content).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  /**
   * Function that closes the popup that shows the songs lyrics
   * @param reason
   * @returns {string}
   */
  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return `with: ${reason}`;
    }
  }
}
