import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';

import { WorksIndexComponent } from './works_index.component';

@NgModule({
  declarations: [
    WorksIndexComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
  ],
  providers: [],
  bootstrap: [ WorksIndexComponent ]
})
export class WorksIndexModule { }
