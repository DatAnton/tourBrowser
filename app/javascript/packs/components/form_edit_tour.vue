<template>
  <div>
    <div class="alert alert-warning" role="alert" v-for="error in errors">
      {{ error }}
    </div>

    <div class="d-flex align-items-center" v-if="saving">
      <strong>Сохранение...</strong>&nbsp;&nbsp;&nbsp;
      <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
      </div>
    </div>

    <div class="form-group">
      <div class="container-fluid page">
         <div class="row">
             <div class="offset-4 col-6">
               <label for="">Имя тура</label>
               <input type="text" v-model="tour.name" class="form-control" placeholder="What is name?">
              </div>
          </div>
        </div>
    </div>

    <div class="form-group">
      <div class="container-fluid page">
         <div class="row">
             <div class="offset-4 col-6">
                <label for="">Описание</label>
                <textarea v-model="tour.description" rows="10" class="form-control" placeholder="What you will see?"></textarea>
              </div>
          </div>
        </div>
    </div>

    <div class="form-group">
      <div class="container-fluid page">
         <div class="row">
             <div class="offset-4 col-6">
      &nbsp;<input type="checkbox" v-model="tour.is_private">
      <label for="horns">Приватный?</label><br>
              </div>
          </div>
        </div>
    </div>

    <h3 class="text-center" style="margin:100px 0 25px 0">Выберите локацию</h3>

    <div class="form-group">
      <div class="container-fluid page">
         <div class="row">
             <div class="offset-4 col-6">
               <label for="">Область</label>
              <select v-model="selectedRegion" class="form-control">
                <option v-for="regin in regions" v-bind:value="regin">{{ regin }}</option>
              </select>
              </div>
          </div>
      </div>
    </div>

      <div class="form-group">
        <div class="container-fluid page">
           <div class="row">
               <div class="offset-4 col-6">
                 <label for="">Город</label>
                  <select v-model="tour.location_id" class="form-control">
                    <option v-for="location in locations" v-bind:value="location.id">{{ location.name }}</option>
                  </select><br>
                </div>
              </div>
            </div>
          </div>



          <h3 class="text-center" style="margin:100px 0 25px 0">Фотографии</h3>
          <div class="container-fluid page">
            <div class="row">
              <div class="offset-4 col-6">
                <label for="">Выберите главную фотографию:</label>
                    <br>
                    <img v-if="tour.main_image != null && tour.main_image.id != 0" v-bind:src="tour.main_image.image"
                      class="uploading-image" style="border: double yellow 3px;"/>
                    <img v-else="tour.main_image != null" v-bind:src="tour.main_image.image"
                      class="uploading-image" />
                    <input type="file" accept="image/jpeg" @change="uploadImage">


          <h4>Галерея:</h4>
          <div class="" v-for="imag in tour.images">
            <img v-if="imag.id != 0" v-bind:src="imag.image" class="uploading-image" style="border: double yellow 3px;"/>
            <img v-else v-bind:src="imag.image" class="uploading-image" />
            <button type="button" name="button" class="btn btn-danger" @click="deleteImage(imag)">удалить</button>
            <br>
          </div>
          <label for="">Выберите другие фотографии:</label>
          <input type="file" multiple="multiple" accept="image/jpeg" @change="uploadGallery"><br>

          <button type="button" name="button" v-on:click="sendData" class="btn btn-primary" v-bind:disabled="saving">Сохранить</button>


              </div>
            </div>
          </div>
  </div>
</template>

<script>
export default {
  props: {
    tour_in: {
      type: Object,
      required: true
    },
    location_in: {
      type: Object,
      required: true
    },
    main_image_in: {
      type: Object,
      required: true
    },
    images_in: {
      type: Array,
      required: true
    }
  },
  data: function () {
    return {
      tour: {
        id: this.tour_in.id,
        name: this.tour_in.name,
        description: this.tour_in.description,
        location_id: this.tour_in.location_id,
        main_image: this.main_image_in,
        is_private: this.tour_in.is_private,
        images: []
      },
      regions: Array,
      selectedRegion: '',
      locations: Array,
      errors: Array,
      saving: false
    }
  },
  methods: {
    deleteImage: async function(img){
      this.tour.images = this.tour.images.filter(function(item) {
        return item !== img
      });
      if (img.id != 0) {
        var self = this;
        const response = await fetch(`/tours/${this.tour.id}/images/${img.id}`, {
          method: 'DELETE',
          body: JSON.stringify({ id: img.id, tour_id: self.tour.id }),
          headers:{
            'Content-Type': 'application/json'
          }
        });
        const res = await response.json();
        self.tour.main_image = res;
      }
    },
    uploadImage(e){
        const image = e.target.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(image);
        reader.onload = e =>{
            this.tour.main_image = { id: 0, image: e.target.result };
        };
    },
    uploadGallery(e){
      var images = e.target.files;
      var image;
      for(var i = 0; i < e.target.files.length; i++)
      {
        const reader = new FileReader();
        image = images[i];
        reader.readAsDataURL(image);
        reader.onload = e =>{
          this.tour.images.push({ id: 0, image: e.target.result });
        };
      }

    },
    sendData: async function(){
      var self = this;
      this.saving = true;
      const response = await fetch(`/tours/${this.tour.id}`, {
        method: 'PUT',
        body: JSON.stringify(self.tour),
        headers:{
          'Content-Type': 'application/json'
        }
      });
      const result = await response.json();
      if(result.errors){
        self.errors = result.errors;
        self.saving = false;
      }
      else {
        window.location.href = `/tours/${result.id}`;
      }
    }
  },
  mounted: async function() {
    const response = await fetch('/tours/get_regions');
    const regins = await response.json();
    this.regions = regins;
    this.selectedRegion = this.location_in.region;

    this.tour.images = this.images_in;
  },
  watch: {
    selectedRegion: async function(){
      const response = await
        fetch(`/tours/get_locations_by_region?region=${this.selectedRegion}`);
      const locatins = await response.json();
      this.locations = locatins;
    }
  }
}
</script>

<style>
.uploading-image{
  display:inline;
  weight:200px;
  height:150px
}

</style>
