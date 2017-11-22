import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { BrowserModule } from "@angular/platform-browser";

import 'rxjs/add/operator/map';

@Component({
  selector: 'works-index',
  template: `
  <progress [class.bar-white]="!loading" class="col-12 progress-bar pb-4" value="{{loading_procent}}" max="100"></progress>
  <div class="row sortable works-wrapper" [class.show-index-works]="!loading">
    <div *ngFor="let work of works; let i = index" class="overview-work sortable-item" [attr.data-id]="work.id" [attr.data-type]="">
          <img *ngIf="work.overview_img.url" [src]="work.overview_img.url" (load)="showRealImages()" hidden>
          <a [href]="'/works/' + work.slug">
            <div *ngIf="!work.overview_img.url" class="overview-img-block work-without-image">
            </div>
            <div *ngIf="work.overview_img.url" class="overview-img-block" [style.background-image]="'url(' + work.overview_img.url + ')'">
            </div>
            <h2 class="overview-work-h2">{{work.name}}</h2>
          </a>
          <!-- 
          Work WIHTOUT IMAGES
          -->
    </div>
    <!-- FIXED FLEXBOX FLOAT LEFT ISSUE -->
    <div class="overview-work">
      <div class="overview-img-block"></div>
    </div>
    <div class="overview-work hidden-md-down">
      <div class="overview-img-block"></div>
    </div>
    <div class="overview-work hidden-md-down">
      <div class="overview-img-block"></div>
    </div>

  </div>
  `
})

export class WorksIndexComponent implements OnInit {
  works: {}[] = [];
  images_count: number;
  new_image_counter: number = 0;
  loading: boolean = true;
  loading_procent: number = 0;
  constructor( private http: Http ) {}

  ngOnInit() {
    var category_friendly_id = document.getElementById('categoryId').getAttribute('data-category-id');
    this.getWorks(category_friendly_id)
      .subscribe(
        data => this.works = data.works,
        err => console.log(err),
        () => {
          this.countImages();
          console.log(this.works);
        }
      )
    
  }
  showRealImages() {
    this.new_image_counter += 1;
    this.loading_procent += (100/ this.images_count);
    console.log(this.loading_procent);
    if(this.new_image_counter == this.images_count - 1) {
      this.loading = false;
    }
    console.log(this.new_image_counter + " == " + this.images_count);
  }

  countImages = function() {
    this.images_count = this.works.filter((work) => work.overview_img.url ).length;
  }

  getWorks(category_id) {
    return this.http.get("/vaerker/" + category_id + ".json")
      .map(response => response.json())
  }
}
