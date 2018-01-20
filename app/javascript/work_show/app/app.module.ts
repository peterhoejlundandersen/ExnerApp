import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';

import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { WorkShowComponent } from './work_show.component';

import { DragulaModule } from 'ng2-dragula/ng2-dragula';

@NgModule({
  declarations: [
    WorkShowComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    DragulaModule
  ],
  providers: [ImageService, ImageNavigatorService],
  bootstrap: [ WorkShowComponent ]
})
export class AppModule { }
