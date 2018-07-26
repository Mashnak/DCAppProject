import {Component, OnInit} from '@angular/core';
import {Injectable} from '@angular/core';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {Http} from '@angular/http';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {Observable} from 'rxjs/Observable';
import {SongService} from './song.service';
import {Song} from '../song';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

@Injectable()
export class AppComponent implements OnInit {
  title = 'Song Search';
  closeResult: string;
  searchResult: Observable<Song>;

  /**
   * Constructor that is called when Application is started
   * @param {Http} http
   * @param {NgbModal} modalService
   * @param {SongService} songservice
   */
  constructor(private http: Http, private modalService: NgbModal, private songservice: SongService) {
  }

  /**
   * Function that calls the service that gets all songs from the Business Logic
   */
  ngOnInit() {
    this.songservice.getRandom().subscribe(data => {
      this.searchResult = data;
    });
  }

  /**
   * Function that calls the service that gets the correct song from the Business Logic depending on the users searchterm
   * @param searchForm
   */
  onSubmit(searchForm) {
    this.songservice.getSong(searchForm).subscribe(data => {
      this.searchResult = data; console.log(this.searchResult);
    });
  }

  /**
   * Adds a specific song to the users favoritelist (not implemented correctly)
   * @param songItem
   */
  onAddedToFavorites(songItem) {
    this.songservice.postSongToFavorites(songItem.name);
  }

  /**
   * Function that opens the popup to register a new user
   * @param content
   */
  open(content) {
    console.log(typeof (content));
    this.modalService.open(content).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  /**
   * Function that closes the popup to regsiter a new user
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
