import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';
import { pdfjsViewer } from "angular-pdfjs-viewer";

@Component({
  selector: 'pdfjs-viewer',
  template: `<pdfjs-viewer src="{{ pdf.src }}></pdfjs-viewer>`
})

export class PdfShowComponent implements OnInit {
  pdf: Object
  
  constructor(
  private _http: Http,
  ){ }

  ngOnInit() {
    var file_path = document.getElementById('pdfId').getAttribute('data-path');
    console.log(file_path);
    this.pdf = { src: "https://exnerbilleder.s3.eu-west-2.amazonaws.com/pdf/Kirkeforhold/1965.2%20Kirkebygningens%20indre%20og%20ydre%20enhed%20-%20Kirkebygning%20og%20teologi.pdf" }
  }
}


