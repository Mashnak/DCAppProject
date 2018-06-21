import {Component} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Injectable} from '@angular/core';

@Component({
  selector: 'app-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

@Injectable()
export class AppComponent {
  title = 'Song Search';

  constructor(private http: HttpClient) {
  }

  songItems = [{
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
    artists: ['Testartist1']
  },
    {
      id: 2,
      name: 'Testname2',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname3',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname4',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname5',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname6',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname7',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname8',
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
      artists: ['Testartist1']
    },
    {
      id: 2,
      name: 'Testname9',
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
      artists: ['Testartist1']
    },
    {
      id: 10,
      name: 'Testname10',
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
      artists: ['Testartist1']
    },
    {
      id: 11,
      name: 'Testname11',
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
      artists: ['Testartist1']
    }
  ];

  onAddedToFavorites(songItem) {
    console.log(songItem);
    // Add the post method to the BL!!!!
  }

  onSubmit(searchForm) {
    console.log(searchForm);
    const searchValue = (JSON.stringify(searchForm.searchText));
    console.log(' http://192.168.99.10:8080/search?term=' + searchValue);
  }
}
