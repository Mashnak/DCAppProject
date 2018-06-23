import {Component, Input, Output, EventEmitter} from '@angular/core';
import {Http} from '@angular/http';
import {Injectable} from '@angular/core';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {Result} from '../Result';

@Component({
  selector: 'app-songitem',
  templateUrl: 'songitem.html',
  styleUrls: ['songitem.css', '../../node_modules/bootstrap/dist/css/bootstrap.min.css']
})

@Injectable()
export class SongitemComponent {
  closeResult: string;

  constructor(private http: Http, private modalService: NgbModal) {
  }

  readonly ROOT_URL = 'http://192.168.99.100:8080';

  @Input() searchResult;
  @Output() addedToFavorites = new EventEmitter();

  // sends an event to app.component.ts if a song is requested to add to a playlist
  postSongToFavorites() {
    this.addedToFavorites.emit(this.searchResult);
    console.log('added ' + this.searchResult +  ' to favorites');
  }

  onSubmit(songTag) {
    console.log(songTag);
    return this.http.post(this.ROOT_URL, songTag);
  }

  open(content) {
    this.modalService.open(content).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

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
