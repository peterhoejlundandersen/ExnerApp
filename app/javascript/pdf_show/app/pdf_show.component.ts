import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';
import { pdfjsViewer } from "angular-pdfjs-viewer";

@Component({
  selector: 'pdfjs-viewer',
  template: `<h1>Heeey</h1>`
})

export class PdfShowComponent implements OnInit {
  
  constructor(
  private _http: Http,
  ){ }

  ngOnInit() {
    var file_path = document.getElementById('pdfId').getAttribute('data-path');
    console.log(file_path);
  }
}


