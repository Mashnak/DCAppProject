import {Component, OnInit} from '@angular/core';
import {Injectable} from '@angular/core';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {Http, Response, RequestOptions, Headers, HttpModule, URLSearchParams} from '@angular/http';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

@Injectable()
export class AppComponent implements OnInit {
  title = 'Song Search';
  closeResult: string;

  constructor(private http: Http, private modalService: NgbModal) {
  }

  readonly ROOT_URL: string = 'http://192.168.99.100:8080';

  ngOnInit() {
    const url = this.ROOT_URL + '/random';
    let search = new URLSearchParams();
    search.set('count', '10');
    this.http.get(url, {search}).subscribe(res => console.log(res.json()));
  }

  onSubmit(searchForm) {
    const url = this.ROOT_URL + '/search';
    let search = new URLSearchParams();
    search.set('term', searchForm.searchText);
    this.http.get(url, {search}).subscribe(res => console.log(res.json()));
  }

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // return this.http.post<Song>(this.ROOT_URL, songItem);
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
