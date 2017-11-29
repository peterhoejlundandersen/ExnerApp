import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { BrowserModule } from "@angular/platform-browser";

import 'rxjs/add/operator/map';

@Component({
  selector: 'categories-index', 
  template: `
  <div *ngFor="let category of categories">
    {{category}}
  </div>
  `
})

export class CategoriesIndexComponent implements OnInit {
  categories: number[] = [1,2,3,4,5,6,7];
  categories_default: {}[] = [];
  constructor( private http: Http ) {}

  ngOnInit() {
    this.getCategories()
      .subscribe(
        // data => {
        //   this.categories = data.categories,
        // },
        // err => console.log(err),
      )
    
  }

  getCategories() {
    return this.http.get("oversigt.json")
      .map(response => response.json())
  }
}

