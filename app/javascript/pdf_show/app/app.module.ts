import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { PdfShowComponent } from './pdf_show.component';

import { PdfViewerModule } from 'ng2-pdf-viewer';

@NgModule({
  declarations: [
    PdfShowComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    PdfViewerModule
  ],
  bootstrap: [ PdfShowComponent ]
})
export class AppModule { }
