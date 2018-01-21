import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule, Response, Headers, RequestOptions } from '@angular/http';
import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { ImageCat } from './image_cat';

import { DragulaService } from 'ng2-dragula/ng2-dragula';

@Component({
  selector: 'work-show',
  template: `
  <div class="next-prev-back-wrapper row">
    <div class="col-6 nav-link">
      <a *ngIf="prev_work" [attr.href]="'/works/' + prev_work?.slug">
        <span class="pagination-arrows prev-work"></span>
				<span class="ar-work-hidden-md-down">{{prev_work?.name}}</span>
				<span class="ar-work-hidden-md-up">Forrige værk</span>
      </a>
    </div>
    <div class="col-6 nav-link text-right ">
      <a *ngIf="next_work" [attr.href]="'/works/' + next_work?.slug">
				<span class="ar-work-hidden-md-down">{{next_work?.name}}</span>
				<span class="ar-work-hidden-md-up">Næste værk</span>
        <span class="pagination-arrows next-work">
      </span></a>
    </div>
  </div>
  <h1 class="text-center">{{work?.title}}</h1>
  <div class="large-image">
    <div *ngIf="large_image" class="vertical-center">
      <div class="image-desc-wrapper">
        <div src="#" *ngIf="image_loading" class="loading"></div>
        <img [hidden]="image_loading" (load)="onImageLoad()" [attr.src]="large_image.image.url" id="largeImage">
        <div class="work-arrows ar-hidden-md-down large-arrow-left" id="leftArrow" (click)="changeLargeImage(image_index - 1)"></div>
        <div class="work-arrows ar-hidden-md-down large-arrow-right" id="rightArrow" (click)="changeLargeImage(image_index + 1)"></div>
      </div>
    </div>
		<div *ngIf="!image_loading && large_image.image_description" class="image-description">
			<p class="text-center">{{large_image.image_description}}</p>
		</div>
  </div>

	<div class="row next-prev-back-wrapper ar-hidden-md-up">
    <div class="col-6 nav-link" (click)="changeLargeImage(image_index - 1)">
        <span class="pagination-arrows prev-work"></span>
				<span>Forrige billede</span>
		</div>
			<div class="col-6 nav-link text-right" (click)="changeLargeImage(image_index + 1)">
				<span>Næste billede</span>
        <span class="pagination-arrows next-work"></span>
		</div>
	</div>
  <!-- work_info -->
  <div *ngIf="work_info || work_description" [class.show-info]="work_info_opened" class="row info-field-work">
    <div class="info-kort col-md-4">
      <ul class="info-short-list">
        <li *ngIf="work.title">{{work?.title}}</li>
        <li *ngFor="let info of work_info">{{info}}</li>
				<li *ngIf="work.map_info">
					<a [attr.href]="'/danmarkskort?id=' + work.id" target="_blank"> Vis på kort &#8594; </a>
				</li>
      </ul>
    </div>
    <div class="info-beskrivelse col-md-8">
      <p [innerHTML]="returnWorkDescription(work_description)"></p>
    </div>
  </div>
  <!-- image categories -->

	<div class="blog-nav img-cat-nav" data-navbar="img">
    <span *ngIf="work_info" [class.active-cat]="work_info_opened" class="info-button no-drag" (click)="openInfo()">Info</span>
		<span *ngIf="image_cats?.length > 1" class="info-button hidden-md-up selected-image-cat">{{selected_cat}}</span>
		<div *ngIf="logged_in" class="image-cat-wrapper" [dragula]='"cat-bag"' [dragulaModel]='image_cats'>
			<div *ngFor="let image_cat of image_cats; let i = index"
			class="nav-link text-center hidden-md-down"
			[class.active-cat]="i == image_cats_index"
			[attr.data-id]="image_cat.id"
			data-type="image-cat">
				<div (click)="changeCategory(i)" class="nav-link text-center">
					{{image_cat.name}}
				</div>
			</div>
		</div>
		<div *ngIf="!logged_in" class="image-cat-wrapper">
			<div *ngFor="let image_cat of image_cats; let i = index"
			class="nav-link text-center hidden-md-down"
			[class.active-cat]="i == image_cats_index">
				<div (click)="changeCategory(i)" class="nav-link text-center">
					{{image_cat.name}}
				</div>
			</div>
		</div>
		<select *ngIf="image_cats?.length > 1" (change)="triggerChangeCategory($event)" name="image-cat" class="no-drag hidden-md-up image-cat-dropdown">
			<option selected>Skift billedekategori</option>
			<option *ngFor="let image_cat of image_cats; let i = index" [value]="i">
				{{image_cat.name}}
			</option>
		</select>
  </div>
  <!-- thumbnails -->
<div class="thumb-images-wrapper">
	<div class="col-12">
		<div class="loading-bar" [style.width]="loading_procent + '%'"></div>
	</div>
	<ng-container *ngIf="logged_in">
  <div class="thumb-images row sortable-images"
    [dragula]='"first-bag"' [dragulaModel]='thumb_images'>
    <div *ngFor="let thumb_image of thumb_images; let i = index"
		[class.no-drag]="!logged_in" 
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-sm-4"
    (click)="changeLargeImage(i)"
    [attr.data-id]="thumb_image?.id" data-type="image">
      <img (load)="thumbNailLoad()" src="{{thumb_image?.image.thumb.url}}"
      [class.thumbnail-images-loadet]="!thumbnail_loading"
      [class.thumbnail-active]="i == image_index && !thumbnail_loading">
    </div>
  </div>
	</ng-container>
	<ng-container *ngIf="!logged_in">
	<div class="thumb-images row sortable-images">
    <div *ngFor="let thumb_image of thumb_images; let i = index"
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-sm-4"
		(click)="changeLargeImage(i)">
      <img (load)="thumbNailLoad()" src="{{thumb_image?.image.thumb.url}}"
      [class.thumbnail-images-loadet]="!thumbnail_loading"
      [class.thumbnail-active]="i == image_index && !thumbnail_loading">
    </div>
  </div>
	</ng-container>
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
	selected_cat: string = "";
  large_image: null;
  image_index: number = 0;
  image_cats_index: number = 0;
  work_info: null;
  work_description: null;
  work_info_opened: boolean = false;
  work: null;
	logged_in: boolean = false;

  constructor( 
    private http: Http,
    private _image_service: ImageService,
    public _image_navigator_service: ImageNavigatorService,
    private dragulaService: DragulaService
  ) {

    dragulaService.drop.subscribe((value) => {
      var element = value.slice(1)[0];
      var children = [].slice.call(element.parentElement.children);
			console.log(element.dataset.id);
      var sorting_data = new Array();
      children.forEach(function(div, index) {
				if (div.dataset.id == null) { return }
        let index_of_div = children.indexOf(div);
				console.log("Index: " + index_of_div + "### id: " + div.dataset.id);
        sorting_data.push({id: div.dataset.id, order_i: index_of_div, type: div.dataset.type});
      });
      var url = "/sorting-objects";
      var body = JSON.stringify(sorting_data);
      let headers = new Headers({ 'Content-Type': 'application/json' }); // ... Set content type to JSON
      let options = new RequestOptions({ headers: headers }); // Create a request option
      this.http.post(url, body, options).subscribe(
          data => { }, err => { console.log("FEJL:" + err); }
        )
    });


  };

  thumbNailLoad = function() {
    this.thumbnail_loading_counter = this.thumbnail_loading_counter + 1;
    var thumbnail_length = this.thumb_images.length - 1;
    this.loading_procent += ( 100 / thumbnail_length );
    if (this.thumbnail_loading_counter > thumbnail_length) {
      this.thumbnail_loading = false, this.thumbnail_loading_counter = 0, this.loading_procent = 0; //Nulstil værdierne
    }
  }
  returnWorkDescription(work_des) { // Linebreaks i beskrivelsen!
    return work_des.replace(new RegExp('\n', 'g'), "<br />");
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
				this.selected_cat = data.image_cats[0].name,
        this.large_image = data.large_image,
        this.work_info = data.work_info.short,
        this.work_description = data.work_info.description,
        this.next_work = data.pagination.next,
        this.prev_work = data.pagination.prev,
        this.parent_cat = data.parent_cat,
				this.work = data.work,
				this.logged_in = data.logged_in
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
  }

  changeCategory = function(i, last = false) { // Get image data from the json call
    this.thumbnail_loading = true;
    var [image_cat_id, image_cats_index] = this._image_navigator_service.categoryChangerChecker(this.image_cats, i); 
		this.selected_cat = this.image_cats[image_cats_index].name;
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

	triggerChangeCategory = function(e) {
		let int = Number(e.target.value);
		this.changeCategory(int);
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
