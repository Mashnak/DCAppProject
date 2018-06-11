import {Component, Input} from '@angular/core';


@Component({
  selector: 'app-albumitem',
  templateUrl: './albumitem.component.html',
  styleUrls: ['./albumitem.component.css']
})
export class AlbumitemComponent {
  @Input() albumitem;
}
