import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';

const DEFAULT_ZOOM:number = 1;

@Component({
  selector: 'pdf-show',
  template: ` 

  <div class="zoom-btn-wrapper">
    <span class="zoom-btn zoom-in" (click)="zoomIn()">+</span>
    <span class="zoom-btn zoom-out" (click)="zoomOut()">-</span>
  </div>
  <pdf-viewer 
    [src]="pdfSrc" 
    [render-text]="true" 
    style="display: block;" 
    [fit-to-page]="true"
    [zoom]="zoom_int"></pdf-viewer> `
})

export class PdfShowComponent implements OnInit {
  public pdfSrc: string;
  public zoom_int: number = DEFAULT_ZOOM;
  
  ngOnInit() {
    var file_path = document.getElementById('pdfId').getAttribute('data-path');
    this.pdfSrc  = file_path;
  }

  zoomIn = function() {
    this.zoom_int += 0.1;
  }
  zoomOut = function() {
    this.zoom_int -= 0.1;
  }
}


