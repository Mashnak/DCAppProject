import {Component} from '@angular/core';

@Component({
  selector: 'app-songitemlist',
  templateUrl: './songitemlist.html',
  styleUrls: ['./songitemlist.css']
})
export class SongItemListComponent {

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // return this.http.post<Song>(this.ROOT_URL, songItem);
  }
  songItems = [
    {
      id: 1,
      name: 'Testname1',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: 'Robert\'s got a quick hand\n' +
      'He\'ll look around the room, he won\'t tell you his plan\n' +
      'He\'s got a rolled cigarette, hanging out his mouth he\'s a cowboy kid\n' +
      'Yeah found a six shooter gun\n' +
      'In his dad\'s closet hidden oh in a box of fun things, I don\'t even know what\n' +
      'But he\'s coming for you, yeah he\'s coming for you\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'Daddy works a long day\n' +
      'He be coming home late, he\'s coming home late\n' +
      'And he\'s bringing me a surprise\n' +
      '\'Cause dinner\'s in the kitchen and it\'s packed in ice\n' +
      'I\'ve waited for a long time\n' +
      'Yeah the slight of my hand is now a quick pull trigger\n' +
      'I reason with my cigarette\n' +
      'And say your hair\'s on fire, you must have lost your wits, yeah\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet',
      URLs: ['https://www.youtube.com/watch?v=KhzGSHNhnbI'],
      genres: ['Testgenre'],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1'],
      img: 'https://i.scdn.co/image/716410ed2e63347bfb326d1c768e1fcb316f9542'
    }, {
      id: 1,
      name: 'Testname1',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: 'Robert\'s got a quick hand\n' +
      'He\'ll look around the room, he won\'t tell you his plan\n' +
      'He\'s got a rolled cigarette, hanging out his mouth he\'s a cowboy kid\n' +
      'Yeah found a six shooter gun\n' +
      'In his dad\'s closet hidden oh in a box of fun things, I don\'t even know what\n' +
      'But he\'s coming for you, yeah he\'s coming for you\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'Daddy works a long day\n' +
      'He be coming home late, he\'s coming home late\n' +
      'And he\'s bringing me a surprise\n' +
      '\'Cause dinner\'s in the kitchen and it\'s packed in ice\n' +
      'I\'ve waited for a long time\n' +
      'Yeah the slight of my hand is now a quick pull trigger\n' +
      'I reason with my cigarette\n' +
      'And say your hair\'s on fire, you must have lost your wits, yeah\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet',
      URLs: ['https://www.youtube.com/watch?v=KhzGSHNhnbI'],
      genres: ['Testgenre'],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1'],
      img: 'https://i.scdn.co/image/716410ed2e63347bfb326d1c768e1fcb316f9542'
    }, {
      id: 1,
      name: 'Testname1',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: 'Robert\'s got a quick hand\n' +
      'He\'ll look around the room, he won\'t tell you his plan\n' +
      'He\'s got a rolled cigarette, hanging out his mouth he\'s a cowboy kid\n' +
      'Yeah found a six shooter gun\n' +
      'In his dad\'s closet hidden oh in a box of fun things, I don\'t even know what\n' +
      'But he\'s coming for you, yeah he\'s coming for you\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'Daddy works a long day\n' +
      'He be coming home late, he\'s coming home late\n' +
      'And he\'s bringing me a surprise\n' +
      '\'Cause dinner\'s in the kitchen and it\'s packed in ice\n' +
      'I\'ve waited for a long time\n' +
      'Yeah the slight of my hand is now a quick pull trigger\n' +
      'I reason with my cigarette\n' +
      'And say your hair\'s on fire, you must have lost your wits, yeah\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet',
      URLs: ['https://www.youtube.com/watch?v=KhzGSHNhnbI'],
      genres: ['Testgenre'],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1'],
      img: 'https://i.scdn.co/image/716410ed2e63347bfb326d1c768e1fcb316f9542'
    }, {
      id: 1,
      name: 'Testname1',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: 'Robert\'s got a quick hand\n' +
      'He\'ll look around the room, he won\'t tell you his plan\n' +
      'He\'s got a rolled cigarette, hanging out his mouth he\'s a cowboy kid\n' +
      'Yeah found a six shooter gun\n' +
      'In his dad\'s closet hidden oh in a box of fun things, I don\'t even know what\n' +
      'But he\'s coming for you, yeah he\'s coming for you\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'Daddy works a long day\n' +
      'He be coming home late, he\'s coming home late\n' +
      'And he\'s bringing me a surprise\n' +
      '\'Cause dinner\'s in the kitchen and it\'s packed in ice\n' +
      'I\'ve waited for a long time\n' +
      'Yeah the slight of my hand is now a quick pull trigger\n' +
      'I reason with my cigarette\n' +
      'And say your hair\'s on fire, you must have lost your wits, yeah\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet',
      URLs: ['https://www.youtube.com/watch?v=KhzGSHNhnbI'],
      genres: ['Testgenre'],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1'],
      img: 'https://i.scdn.co/image/716410ed2e63347bfb326d1c768e1fcb316f9542'
    }, {
      id: 1,
      name: 'Testname1',
      length: '3:50',
      releaseDate: '14-5-1992',
      lyrics: 'Robert\'s got a quick hand\n' +
      'He\'ll look around the room, he won\'t tell you his plan\n' +
      'He\'s got a rolled cigarette, hanging out his mouth he\'s a cowboy kid\n' +
      'Yeah found a six shooter gun\n' +
      'In his dad\'s closet hidden oh in a box of fun things, I don\'t even know what\n' +
      'But he\'s coming for you, yeah he\'s coming for you\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'Daddy works a long day\n' +
      'He be coming home late, he\'s coming home late\n' +
      'And he\'s bringing me a surprise\n' +
      '\'Cause dinner\'s in the kitchen and it\'s packed in ice\n' +
      'I\'ve waited for a long time\n' +
      'Yeah the slight of my hand is now a quick pull trigger\n' +
      'I reason with my cigarette\n' +
      'And say your hair\'s on fire, you must have lost your wits, yeah\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet\n' +
      '\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, out run my gun\n' +
      'All the other kids with the pumped up kicks\n' +
      'You\'d better run, better run, faster than my bullet',
      URLs: ['https://www.youtube.com/watch?v=KhzGSHNhnbI'],
      genres: ['Testgenre'],
      tags: ['test1', 'test2'],
      publisher: 'Testpublisher',
      album: 'Testalbum',
      artists: ['Testartist1'],
      img: 'https://i.scdn.co/image/716410ed2e63347bfb326d1c768e1fcb316f9542'
    }
  ];
}

