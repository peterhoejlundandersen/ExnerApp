import { Component, OnInit  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';
import { DomSanitizer, SafeResourceUrl, SafeUrl } from '@angular/platform-browser';
import { BrowserModule } from "@angular/platform-browser";

import 'rxjs/add/operator/map';

@Component({
  selector: 'categories-index', 
  template: `
  <div class="pt-4 sortable oversigt-wrapper">
      <div *ngFor="let category of categories; let i = index" class="oversigt-img-wrapper text-center sortable-item" [attr.data-id]="category.id" data-type="Category">
          <a [attr.href]="'vaerker/' + category.slug">
            <img *ngIf="category.image.url" [src]="category.image.url" (load)="assignImageValue(category.image.url, i)" hidden>
            <div class="center-block overview-img" [attr.id]="'overviewImage' + i">
            </div>
            <h2 class="overview-header text-center text-uppercase pt-2">{{category.name}}</h2>
          </a>
        <a *ngIf="logged_in" [attr.href]="'/categories/' + category.slug + '/edit'">Rediger kategori</a>
      </div>
    <div *ngFor="let def_category of categories_default" class="text-center oversigt-img-wrapper">
        <a [attr.href]="def_category.slug">
        <img [src]="def_category.image" (load)="assignImageValue(def_category.image, def_category.id)" hidden>
          <div class="center-block overview-img" [attr.id]="'overviewImage' + def_category.id">
          </div>
          <h2 class="overview-header text-center text-uppercase pt-2 ">{{def_category.name}}</h2>
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

  assignImageValue = function(image_url, i) {
    var image = document.getElementById('overviewImage' + i);
    image.setAttribute("style", "background-image: url(" + image_url + ");");
    image.classList.add("overview-img-show");
  }

  safeUrl = function(image_url) {
    return this.sanitizer.bypassSecurityTrustStyle('url(' + image_url + ')');
  }

  getCategories() {
    return this.http.get("oversigt.json")
      .map(response => response.json())
  }
}

