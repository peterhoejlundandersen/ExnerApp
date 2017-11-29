import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { DomSanitizer, SafeResourceUrl, SafeUrl } from '@angular/platform-browser';
import { BrowserModule } from "@angular/platform-browser";

import 'rxjs/add/operator/map';

@Component({
  selector: 'categories-index', 
  template: `
  <div class="pt-4 sortable oversigt-wrapper">
      <div *ngFor="let category of categories"
      class="oversigt-img-wrapper text-center sortable-item"
      [attr.data-id]="category.id" data-type="Category">
          <div class="center-block overview-img" [style.background-image]="safeUrl(category.image.url)">
          </div>
          <h4 class="overview-header text-center text-uppercase pt-2">{{category.name}}</h4>
        <a *ngIf="logged_in" [attr.href]="'/categories/' + category.slug + '/edit'">Rediger kategori</a>
      </div>
    <div *ngFor="let def_category of categories_default" class="text-center oversigt-img-wrapper">
        <a [attr.href]="def_category.slug">
          <div class="center-block overview-img" [style.background-image]="safeUrl(def_category.image)">
          </div>
          <h4 class="overview-header text-center text-uppercase pt-2 ">{{def_category.name}}</h4>
        </a>
    </div>
  </div><!-- oversigt-wrapper -->
  `
})

export class CategoriesIndexComponent implements OnInit {
  categories: {}[] = [];
  categories_default: {}[] = [];
  logged_in: boolean = false;
  constructor( 
    private http: Http,
    private sanitizer: DomSanitizer 
  ) {}

  ngOnInit() {
    this.getCategories()
      .subscribe(
        data => {
          this.categories = data.categories,
          this.logged_in = data.user_logged_in, 
          this.categories_default = data.cat_default
        },
        err => console.log(err),
      )
  }

  safeUrl = function(image_url) {
    return this.sanitizer.bypassSecurityTrustStyle('url(' + image_url + ')');
  }

  getCategories() {
    return this.http.get("oversigt.json")
      .map(response => response.json())
  }
}

