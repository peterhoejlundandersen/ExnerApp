import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';

import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { WorkShowComponent } from './work_show.component';
import { WorksIndexComponent } from './works_index.component';

@NgModule({
  declarations: [
    WorkShowComponent,
    WorksIndexComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
  ],
  providers: [ImageService, ImageNavigatorService],
  bootstrap: [ WorkShowComponent ]
})
export class AppModule { }
