import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-songitem',
  templateUrl: './songitem.component.html',
  styleUrls: ['./songitem.component.css']
})
export class SongitemComponent {
  @Input() songitem;
}
