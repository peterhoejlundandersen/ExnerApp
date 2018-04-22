import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { PdfShowComponent } from './pdf_show.component';

@NgModule({
  declarations: [
    PdfShowComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
  ],
  bootstrap: [ PdfShowComponent ]
})
export class AppModule { }
