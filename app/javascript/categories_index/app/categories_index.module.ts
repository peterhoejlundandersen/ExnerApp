import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { Http, HttpModule } from '@angular/http';
import { CategoriesIndexComponent  } from './categories_index.component';

import { dndLists } from 'angular-drag-and-drop-lists';

@NgModule({
  declarations: [
   CategoriesIndexComponent 
  ],
  imports: [
    dndLists,
    BrowserModule,
    HttpModule
  ],
  providers: [ ],
  bootstrap: [ CategoriesIndexComponent ]
})
export class CategoriesIndexModule{ }

