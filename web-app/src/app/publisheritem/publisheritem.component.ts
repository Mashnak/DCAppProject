import {Component, Input} from '@angular/core';


@Component({
  selector: 'app-publisheritem',
  templateUrl: './publisheritem.component.html',
  styleUrls: ['./publisheritem.component.css']
})
export class PublisheritemComponent {
  @Input() publisheritem;
}
