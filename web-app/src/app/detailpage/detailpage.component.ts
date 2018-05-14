import {Component, Input} from '@angular/core';

@Component({
  selector: 'app-detailpage',
  templateUrl: './detailpage.component.html',
  styleUrls: ['./detailpage.component.css']
})
export class DetailpageComponent {
  title = 'Detail Page';
  @Input() songitem;
}
