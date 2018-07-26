import {Injectable} from '@angular/core';

@Injectable()
export class UrlService {
  readonly ROOT_URL: string = 'http://192.168.99.100:8080';

  constructor() {
  }

  /**
   * Provides the correct root url for the other services to communicate with the Business Logic
   * @returns {string}
   */
  getURL() {
    return this.ROOT_URL;
  }
}
