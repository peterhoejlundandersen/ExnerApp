import { Component, OnInit } from '@angular/core';
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';

import { BrowserModule } from "@angular/platform-browser";
import { DragulaService } from 'ng2-dragula/ng2-dragula';

import 'rxjs/add/operator/map';

@Component({
  selector: 'works-index',
  template: `
  <div class="row sortable works-wrapper" [dragula]='"first-bag"' [dragulaModel]='works'> 
    <div *ngFor="let work of works; let i = index" [class.vertical-image]="organs" class="overview-work sortable-item" [attr.data-id]="work.id" [attr.data-type]="">
          <img *ngIf="work.overview_img.url" [src]="work.overview_img.url" (load)="assignImageValue(i, work.overview_img.url)" hidden>
          <a [href]="'/works/' + work.slug">
            <div *ngIf="!work.overview_img.url" class="overview-img-block overview-img-block-show work-without-image">
            </div>
            <div *ngIf="work.overview_img.url" class="overview-img-block" [attr.id]="'imageId' + i">
            </div>
            <h2 class="overview-work-h2">{{work.name}}</h2>
          </a>
    </div>
    <!-- FIXED FLEXBOX FLOAT LEFT ISSUE -->
    <div [class.vertical-image]="organs" [class.no-drag]="binding" *ngIf="works.length !== 3" class="overview-work">
      <div class="overview-img-block"></div>
    </div>
    <div [class.vertical-image]="organs" [class.no-drag]="binding"  *ngIf="works.length != 3" class="overview-work hidden-md-down">
      <div class="overview-img-block"></div>
    </div>
    <div [class.vertical-image]="organs" [class.no-drag]="binding"  *ngIf="works.length != 3" class="overview-work hidden-md-down">
      <div class="overview-img-block"></div>
    </div>

  </div>
  `
})

export class WorksIndexComponent implements OnInit {
  organs: boolean = false;
  works: {}[] = [];
  constructor( 
    private http: Http,
    private dragulaService: DragulaService
  ) {
  dragulaService.dropModel.subscribe((value) => {
    var element = value.slice(1)[0];
    [].slice.call(element.parentElement.children).indexOf(element)
    // var children = document.querySelectorAll('overview-work');
    var sorting_data = new Array();
    var children = [].slice.call(element.parentElement.children);
    children.forEach(function(image, index) {
      let index_of_image = children.indexOf(image);
      debugger;
      sorting_data.push({id: image.dataset.id, order_i: index_of_image});
    });
    var url = "/sorting-objects";
    var body = JSON.stringify(sorting_data);
    let headers = new Headers({ 'Content-Type': 'application/json' }); // ... Set content type to JSON
    let options = new RequestOptions({ headers: headers }); // Create a request option
    this.http.post(url, body, options).subscribe(
        data => {
          console.log("HEEEEY");
        },
      err => { 
        console.log(err);
      }
      )
    });
  }

  ngOnInit() {
    var category_friendly_id = document.getElementById('categoryId').getAttribute('data-category-id');
    this.getWorks(category_friendly_id)
      .subscribe(
        data => {
          this.works = data.works,
          this.organs = data.organs
        },
        err => console.log(err),
      )
    
  }
  assignImageValue = function(i, image_url) {
    var image = document.getElementById('imageId' + i);
    image.setAttribute("style", "background-image: url(" + image_url + ");");
    image.classList.add("overview-img-block-show");
  }

  getWorks(category_friendly_id) {
    return this.http.get("/vaerker/" + category_friendly_id + ".json")
      .map(response => response.json())
  }
}
