import {Injectable} from '@angular/core';

@Injectable()
export class UrlService {
  readonly ROOT_URL: string = 'http://192.168.99.100:8080';

  constructor() {
  }

  getURL() {
    return this.ROOT_URL;
  }
}
