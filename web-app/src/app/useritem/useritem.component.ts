import {Component, Input} from '@angular/core';


@Component({
  selector: 'app-useritem',
  templateUrl: './useritem.component.html',
  styleUrls: ['./useritem.component.css']
})
export class UseritemComponent {
  @Input() useritem;
}
