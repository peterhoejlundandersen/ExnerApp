import { Component } from '@angular/core';

@Component({
  selector: 'thumbnail-load',
  template: `
  <div class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item" data-id="image.id" data-type="Image">
    <img src="https://exnerbilleder.s3.amazonaws.com/nye/uploads/image/image/989/thumb_L1080217.jpg">
  </div>
  `
})
export class AppComponent {
  name = 'Angular!';
}
