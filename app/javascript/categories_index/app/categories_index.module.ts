import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { Http, HttpModule } from '@angular/http';
import { CategoriesIndexComponent  } from './categories_index.component';

@NgModule({
  declarations: [
   CategoriesIndexComponent 
  ],
  imports: [
    BrowserModule,
    HttpModule
  ],
  providers: [ ],
  bootstrap: [ CategoriesIndexComponent ]
})
export class CategoriesIndexModule{ }

