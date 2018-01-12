import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { DragulaModule } from 'ng2-dragula/ng2-dragula';

import { WorksIndexComponent } from './works_index.component';

@NgModule({
  declarations: [
    WorksIndexComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    DragulaModule
  ],
  providers: [],
  bootstrap: [ WorksIndexComponent ]
})
export class WorksIndexModule { }
