import {Component, Input} from '@angular/core';


@Component({
  selector: 'app-albumitem',
  templateUrl: './artistitem.component.html',
  styleUrls: ['./artistitem.component.css']
})
export class ArtistitemComponent {
  @Input() artistitem;
}
