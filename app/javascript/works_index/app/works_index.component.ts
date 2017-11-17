import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { BrowserModule } from "@angular/platform-browser";

@Component({
  selector: 'works-index',
  template: `<h1> HEEEY </h1>`
})

export class WorksIndexComponent implements OnInit {
  works: null;
  constructor( private http: Http ) {}

  ngOnInit() {
    console.log("IM TURNED ON");
  }
}
