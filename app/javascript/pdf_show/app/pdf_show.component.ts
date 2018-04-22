import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';

@Component({
  selector: 'pdf-show',
  template: `<h1>Heeey</h1>`
})

export class PdfShowComponent implements OnInit {
  
  constructor(
  private http: Http,
  ){ }

  ngOnInit() {
    console.log("heeey! - jeg bliver kaldt først!");
  }
}


