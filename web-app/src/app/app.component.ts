import {Component, OnInit} from '@angular/core';
import {Injectable} from '@angular/core';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {Http} from '@angular/http';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {Observable} from 'rxjs/Observable';
import {SongService} from './song.service';
import {Result} from '../result';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

@Injectable()
export class AppComponent implements OnInit {
  title = 'Song Search';
  closeResult: string;
  searchResult: Observable<Result>;

  constructor(private http: Http, private modalService: NgbModal, private songservice: SongService) {
  }

  ngOnInit() {
    this.songservice.getRandom().subscribe(data => {
      this.searchResult = data;
    });
  }

  onSubmit(searchForm) {
    this.songservice.getSong(searchForm).subscribe(data => {
      this.searchResult = data;
    });
  }

  onAddedToFavorites(songItem) {
    this.songservice.postSongToFavorites(songItem);
    console.log(songItem);
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
