import { Component } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule } from '@angular/http';

@Component({
  selector: 'thumbnail-load',
  template: `
  <div *ngFor="let image of images" class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item" data-id="image.id" data-type="Image">
    <img src="{{image}}">
  </div>
  <button> Få alle billederne</button>
  `
})
export class AppComponent {
  constructor( 
    public http: Http
  ) {
    this.http.get('/works/images.json?image_category_id=10')
      .subscribe(
        data => console.log(data.json())
      )
  };

  images = [
    "https://exnerbilleder.s3.amazonaws.com/nye/uploads/image/image/989/thumb_L1080217.jpg",
    "https://exnerbilleder.s3.amazonaws.com/nye/uploads/image/image/989/thumb_L1080217.jpg",
    "https://exnerbilleder.s3.amazonaws.com/nye/uploads/image/image/989/thumb_L1080217.jpg"
  ];
}
