import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { BrowserModule } from "@angular/platform-browser";

import 'rxjs/add/operator/map';

@Component({
  selector: 'works-index',
  template: `
  <div class="row sortable works-wrapper">
    <div *ngFor="let work of works" class="overview-work sortable-item" [attr.data-id]="work.id" [attr.data-type]="">
          <!-- <img [src]="work.overview_img.url" (load)="showRealImages()"> -->
          <div class="overview-img-block" [style.background-image]="'url(' + work.overview_img.url + ')'">
          </div>
          <h2 class="overview-work-h2">{{work.name}}</h2>
          <!-- 
          Work WIHTOUT IMAGES
          <div class="overview-img-block work-without-image">
          </div>
          -->
    </div>
  </div>
  `
})

export class WorksIndexComponent implements OnInit {
  works: {}[] = [];
  images_count: number;
  constructor( private http: Http ) {}

  ngOnInit() {
    var category_friendly_id = document.getElementById('categoryId').getAttribute('data-category-id');
    this.getWorks(category_friendly_id)
      .subscribe(
        data => this.works = data.works,
        err => console.log(err),
        () => this.countImages()

      )
    
  }
  showRealImages() {

  }
  countImages = function() {
    this.images_count = this.works.filter((work) => work.overview_img.url ).length;
    console.log(this.images_count);
  }

  getWorks(category_id) {
    return this.http.get("/vaerker/" + category_id + ".json")
      .map(response => response.json())
  }
}
