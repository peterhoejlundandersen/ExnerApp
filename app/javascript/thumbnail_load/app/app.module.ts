import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';

import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
  ],
  providers: [ImageService, ImageNavigatorService],
  bootstrap: [AppComponent]
})
export class AppModule { }
