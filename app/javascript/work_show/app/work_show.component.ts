import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";

import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { ImageCat } from './image_cat';

@Component({
  selector: 'work-show',
  template: `
  <!-- large image -->
  <div class="large-image">
    <div *ngIf="large_image" class="vertical-center">
      <div class="image-desc-wrapper">
        <div src="#" *ngIf="image_loading" class="loading"></div>
        <img [hidden]="image_loading" (load)="onImageLoad()" [attr.src]="large_image.image.url" id="largeImage">
        <div class="work-arrows" id="leftArrow" (click)="changeLargeImage(image_index - 1)"></div>
        <div class="work-arrows" id="rightArrow" (click)="changeLargeImage(image_index + 1)"></div>
      </div>
    </div>
  </div>
  <!-- work_info -->

  <div class="next-prev-back-wrapper row">
    <div class="col-md-4 nav-link">
      <a *ngIf="prev_work" [attr.href]="'/works/' + prev_work.slug">
        <span class="pagination-arrows prev-work"></span>
        {{prev_work.name}}
      </a>
    </div>
    <div class="col-md-4 nav-link text-center">
      <a *ngIf="parent_cat" [attr.href]="'/vaerker/' + parent_cat.slug">
        {{parent_cat.name}}
      </a>
    </div>
    <div class="col-md-4 nav-link text-right ">
      <a *ngIf="next_work" [attr.href]="'/works/' + next_work.slug">
        {{next_work.name}}
        <span class="pagination-arrows next-work">
      </span></a>
    </div>
  </div>
  
  <div *ngIf="work_info || work_description" [class.show-info]="work_info_opened" class="row info-field-work">
    <h2 class="col-12">Information</h2>
    <div class="info-kort col-md-4">
      <ul class="info-short-list">
        <li *ngFor="let info of work_info">{{info}}</li>
      </ul>
    </div>
    <div class="info-beskrivelse col-md-8">
      <p>{{work_description}}</p>
    </div>
  </div>
  <!-- image categories -->
  <div class="blog-nav img-cat-nav sortable-images" data-navbar="img">
    <span *ngIf="work_info" [class.active-cat]="work_info_opened" class="info-button" (click)="openInfo()">Info</span>
    <div *ngFor="let image_cat of image_cats; let i = index"
    class="nav-link sortable-image-item text-center"
    [class.active-cat]="i == image_cats_index"
    [attr.data-id]="image_cat.id"
    data-type="ImageCategory">
      <div (click)="changeCategory(i)" class="nav-link sortable-image-item text-center">
        {{image_cat.name}}
      </div>
    </div>
  </div>
  <!-- thumbnails -->
<div class="thumb-images-wrapper">
  <div class="thumb-images row sortable-images">
    <div class="col-12">
      <div class="loading-bar" [style.width]="loading_procent + '%'"></div>
    </div>
    <div *ngFor="let thumb_image of thumb_images; let i = index"
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item"
    (click)="changeLargeImage(i)"
    [attr.data-id]="thumb_image.id" data-type="Image">
      <img (load)="thumbNailLoad()" src="{{thumb_image.image.thumb.url}}"
      [class.thumbnail-images-loadet]="!thumbnail_loading"
      [class.thumbnail-active]="i == image_index && !thumbnail_loading">
    </div>
  </div>
</div>
  `,
  host: {
    '(document:keyup)': 'onKeyUp($event)'
  }
})

export class WorkShowComponent implements OnInit {

  parent_cat: null;
  prev_work: null;
  next_work: null;
  loading_procent: number = 0;
  image_loading: boolean = true;
  thumbnail_loading: boolean = true;
  thumbnail_loading_counter: number = 0;
  thumb_images: null;
  image_cats: null;
  large_image: null;
  image_index: number = 0;
  image_cats_index: number = 0;
  work_info: null;
  work_description: null;
  work_info_opened: boolean = false;

  constructor( 
    private _image_service: ImageService,
    public _image_navigator_service: ImageNavigatorService
  ) {};

  thumbNailLoad = function() {
    this.thumbnail_loading_counter = this.thumbnail_loading_counter + 1;
    var thumbnail_length = this.thumb_images.length - 1;
    this.loading_procent += ( 100 / thumbnail_length );
    if (this.thumbnail_loading_counter > thumbnail_length) {
      this.thumbnail_loading = false, this.thumbnail_loading_counter = 0, this.loading_procent = 0; //Nulstil værdierne
    }
  }
  onImageLoad() {
    this.image_loading = false;
  }

  ngOnInit() {
    var img_cat_id = document.getElementById('imgCat').getAttribute("data-img-cat");
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(data => {
        this.thumb_images = data.images,
        this.image_cats = data.image_cats,
        this.large_image = data.large_image,
        this.work_info = data.work_info.short,
        this.work_description = data.work_info.description,
        this.next_work = data.pagination.next,
        this.prev_work = data.pagination.prev,
        this.parent_cat = data.parent_cat
      });

  }

  openInfo = function() {
    this.work_info_opened = (this.work_info_opened) ? false : true;
  }

  onKeyUp = function(event) {
    if (event.key == "ArrowRight") {
      this.changeLargeImage(this.image_index + 1, this.thumb_images);
    } else if (event.key == "ArrowLeft") {
      this.changeLargeImage(this.image_index - 1, this.thumb_images);
    } 
    if (this.work_info || this.work_description) {
      if (event.key == "ArrowUp") {
        this.work_info_opened = true;
      } else if (event.key == "ArrowDown") {
        this.work_info_opened = false;
      }
    }
  }

  changeCategory = function(i, last = false) { // Get image data from the json call
    this.thumbnail_loading = true;
    var [image_cat_id, image_cats_index] = this._image_navigator_service.categoryChangerChecker(this.image_cats, i); 
    this.image_cats_index = image_cats_index;
    this._image_service.getImagesAndImageCats(image_cat_id)
      .subscribe(
        data => this.thumb_images = data.images,
        err => console.log(err),
        () => {  //Last image should be focused when using arrowkeys prev to another img cat
          this.image_index = (last) ? this.thumb_images.length - 1 : 0;
          this.changeLargeImage(this.image_index);
        }
      )
  }

  changeLargeImage = function(i) {
    this.image_loading = true;
    if (this.thumb_images[i]) { // If the index is inside the scope - normal change
      this.large_image = this.thumb_images[i], this.image_index = i;
    } else { // If not, see if it's the end of the img_cat or the start
      (i < 0) ? this.changeCategory(this.image_cats_index - 1, true) : this.changeCategory(this.image_cats_index + 1) 
    }
  }

}
